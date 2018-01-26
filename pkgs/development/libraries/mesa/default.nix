{ stdenv, fetchurl, fetchpatch, lib
, pkgconfig, intltool, autoreconfHook, substituteAll
, file, expat, libdrm, xorg, wayland, wayland-protocols, openssl
, llvmPackages, libffi, libomxil-bellagio, libva
, libelf, libvdpau, valgrind-light, python2
, grsecEnabled ? false
, enableRadv ? true
# Texture floats are patented, see docs/patents.txt, so we don't enable them for full Mesa.
# It's overridden for mesa_drivers.
, enableTextureFloats ? false
, galliumDrivers ? null
, driDrivers ? null
, vulkanDrivers ? null
, useGLVND ? false, libglvnd
}:

/** Packaging design:
  - The basic mesa ($out) contains headers and libraries (GLU is in mesa_glu now).
    This or the mesa attribute (which also contains GLU) are small (~ 2 MB, mostly headers)
    and are designed to be the buildInput of other packages.
  - DRI drivers are compiled into $drivers output, which is much bigger and
    depends on LLVM. These should be searched at runtime in
    "/run/opengl-driver{,-32}/lib/*" and so are kind-of impure (given by NixOS).
    (I suppose on non-NixOS one would create the appropriate symlinks from there.)
  - libOSMesa is in $osmesa (~4 MB)
*/

with stdenv.lib;

if ! lists.elem stdenv.system platforms.mesaPlatforms then
  throw "unsupported platform for Mesa"
else

let
  defaultGalliumDrivers =
    if stdenv.isArm
    then ["nouveau" "freedreno" "vc4" "etnaviv" "imx"]
    else if stdenv.isAarch64
    then ["nouveau" "vc4" ]
    else ["svga" "i915" "r300" "r600" "radeonsi" "nouveau"];
  defaultDriDrivers =
    if (stdenv.isArm || stdenv.isAarch64)
    then ["nouveau"]
    else ["i915" "i965" "nouveau" "radeon" "r200"];
  defaultVulkanDrivers =
    if (stdenv.isArm || stdenv.isAarch64)
    then []
    else ["intel"] ++ lib.optional enableRadv "radeon";
in

let gallium_ = galliumDrivers; dri_ = driDrivers; vulkan_ = vulkanDrivers; in

let
  galliumDrivers =
    (if gallium_ == null
          then defaultGalliumDrivers
          else gallium_)
    ++ ["swrast"];
  driDrivers =
    (if dri_ == null
      then defaultDriDrivers
      else dri_) ++ ["swrast"];
  vulkanDrivers =
    if vulkan_ == null
    then defaultVulkanDrivers
    else vulkan_;
in

let
  version = "17.2.8";
  branch  = head (splitString "." version);
  driverLink = "/run/opengl-driver" + optionalString stdenv.isi686 "-32";
in

stdenv.mkDerivation {
  name = "mesa-noglu-${version}";

  src =  fetchurl {
    urls = [
      "ftp://ftp.freedesktop.org/pub/mesa/mesa-${version}.tar.xz"
      "ftp://ftp.freedesktop.org/pub/mesa/${version}/mesa-${version}.tar.xz"
      "ftp://ftp.freedesktop.org/pub/mesa/older-versions/${branch}.x/${version}/mesa-${version}.tar.xz"
      "https://mesa.freedesktop.org/archive/mesa-${version}.tar.xz"
    ];
    sha256 = "0pq9kmmyllgd63d936f3x1zsg7sqaswx47khbn0gvbgari2h753f";
  };

  prePatch = "patchShebangs .";

  # TODO:
  #  revive ./dricore-gallium.patch when it gets ported (from Ubuntu), as it saved
  #  ~35 MB in $drivers; watch https://launchpad.net/ubuntu/+source/mesa/+changelog
  patches = [
    ./glx_ro_text_segm.patch # fix for grsecurity/PaX
    ./symlink-drivers.patch
  ];

  outputs = [ "out" "dev" "drivers" "osmesa" ];

  # TODO: Figure out how to enable opencl without having a runtime dependency on clang
  configureFlags = [
    "--sysconfdir=${driverLink}/etc"
    "--localstatedir=/var"
    "--with-dri-driverdir=$(drivers)/lib/dri"
    "--with-dri-searchpath=${driverLink}/lib/dri"
    "--with-platforms=x11,wayland,drm"
  ]
  ++ (optional (galliumDrivers != [])
      ("--with-gallium-drivers=" +
        builtins.concatStringsSep "," galliumDrivers))
  ++ (optional (driDrivers != [])
      ("--with-dri-drivers=" +
        builtins.concatStringsSep "," driDrivers))
  ++ (optional (vulkanDrivers != [])
      ("--with-vulkan-drivers=" +
        builtins.concatStringsSep "," vulkanDrivers))
  ++ [
    (enableFeature enableTextureFloats "texture-float")
    (enableFeature grsecEnabled "glx-rts")
    (enableFeature stdenv.isLinux "dri3")
    (enableFeature stdenv.isLinux "nine") # Direct3D in Wine
    "--enable-dri"
    "--enable-driglx-direct"
    "--enable-glx"
    "--enable-glx-tls"
    "--enable-gallium-osmesa" # used by wine
    "--enable-llvm"
    "--enable-egl"
    "--enable-xa" # used in vmware driver
    "--enable-gbm"
    "--enable-xvmc"
    "--enable-vdpau"
    "--enable-shared-glapi"
    "--enable-sysfs"
    "--enable-llvm-shared-libs"
    "--enable-omx"
    "--enable-va"
    "--disable-opencl"
  ] ++ optionals useGLVND [
    "--disable-gles1"
    "--disable-gles2"
    "--enable-libglvnd"
  ];

  nativeBuildInputs = [ autoreconfHook intltool pkgconfig file ];

  propagatedBuildInputs = with xorg;
    [ libXdamage libXxf86vm ]
    ++ optional stdenv.isLinux libdrm;

  buildInputs = with xorg; [
    expat llvmPackages.llvm
    glproto dri2proto dri3proto presentproto
    libX11 libXext libxcb libXt libXfixes libxshmfence
    libffi wayland wayland-protocols libvdpau libelf libXvMC
    libomxil-bellagio libva libpthreadstubs openssl/*or another sha1 provider*/
    valgrind-light python2
  ] ++ optional useGLVND libglvnd;


  enableParallelBuilding = true;
  doCheck = false;

  installFlags = [
    "sysconfdir=\${out}/etc"
    "localstatedir=\${TMPDIR}"
  ];

  postBuild = optionalString useGLVND ''
    substituteInPlace src/egl/Makefile.am \
      --replace "@LIBGLVND_DATADIR@/glvnd/egl_vendor.d" "$out/share/glvnd/egl_vendor.d"
  '';

  # TODO: probably not all .la files are completely fixed, but it shouldn't matter;
  postInstall = ''
    # move gallium-related stuff to $drivers, so $out doesn't depend on LLVM
    mv -t "$drivers/lib/"    \
      $out/lib/libXvMC*      \
      $out/lib/d3d           \
      $out/lib/vdpau         \
      $out/lib/bellagio      \
      $out/lib/libxatracker* \
      $out/lib/libvulkan_*

    mv $out/lib/dri/* $drivers/lib/dri # */
    rmdir "$out/lib/dri"

    # move libOSMesa to $osmesa, as it's relatively big
    mkdir -p {$osmesa,$drivers}/lib/
    mv -t $osmesa/lib/ $out/lib/libOSMesa*

    # now fix references in .la files
    sed "/^libdir=/s,$out,$osmesa," -i $osmesa/lib/libOSMesa*.la

    # set the default search path for DRI drivers; used e.g. by X server
    substituteInPlace "$dev/lib/pkgconfig/dri.pc" --replace '$(drivers)' "${driverLink}"
  '' + optionalString (vulkanDrivers != []) ''
    # move share/vulkan/icd.d/
    mkdir -p $drivers/share
    mv $out/share/vulkan $drivers/share/
    # Update search path used by Vulkan (it's pointing to $out but
    # drivers are in $drivers)
    for js in $drivers/share/vulkan/icd.d/*.json; do
      substituteInPlace "$js" --replace "$out" "$drivers"
    done
  '';

  # TODO:
  #  check $out doesn't depend on llvm: builder failures are ignored
  #  for some reason grep -qv '${llvmPackages.llvm}' -R "$out";
  postFixup = ''
    # add RPATH so the drivers can find the moved libgallium and libdricore9
    # moved here to avoid problems with stripping patchelfed files
    for lib in $drivers/lib/*.so* $drivers/lib/*/*.so*; do
      if [[ ! -L "$lib" ]]; then
        patchelf --set-rpath "$(patchelf --print-rpath $lib):$drivers/lib" "$lib"
      fi
    done
  '';

  passthru = {
    inherit libdrm driverLink;
    version = "${optionalString useGLVND "glvnd-"}${version}";
  };

  meta = with stdenv.lib; {
    description = "An open source implementation of OpenGL";
    homepage = https://www.mesa3d.org/;
    license = licenses.mit; # X11 variant, in most files
    platforms = platforms.mesaPlatforms;
    maintainers = with maintainers; [ eduarrrd vcunat ];
  };
}
