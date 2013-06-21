{ stdenv, fetchurl, pkgconfig, intltool, flex, bison, autoconf, automake, libtool
, python, libxml2Python, file, expat, makedepend
, libdrm, xorg, wayland, udev, llvm, libffi
, libvdpau
, enableTextureFloats ? false # Texture floats are patented, see docs/patents.txt
, enableR600LlvmCompiler ? false # we would need currently unreleased LLVM or patches
, enableExtraFeatures ? false # add ~15 MB to mesa_drivers
}:

if ! stdenv.lib.lists.elem stdenv.system stdenv.lib.platforms.mesaPlatforms then
  throw "unsupported platform for Mesa"
else

/** Packaging design:
  - The basic mesa ($out) contains headers and libraries (GLU is in mesa_glu now).
    This or the mesa attribute (which also contains GLU) are small (~ 2.2 MB, mostly headers)
    and are designed to be the buildInput of other packages.
  - DRI and EGL drivers are compiled into $drivers output,
    which is bigger (~13 MB) and depends on LLVM (~40 MB).
    These should be searched at runtime in /run/current-system/sw/lib/*
    and so are kind-of impure (given by NixOS).
    (I suppose on non-NixOS one would create the appropriate symlinks from there.)
*/

let
  version = "9.1.3";
  driverLink = "/run/opengl-driver" + stdenv.lib.optionalString stdenv.isi686 "-32";
in
stdenv.mkDerivation {
  name = "mesa-noglu-${version}";

  src = fetchurl {
    url = "ftp://ftp.freedesktop.org/pub/mesa/${version}/MesaLib-${version}.tar.bz2";
    sha256="0rnpaambxv5cd6kbfyvv4b8x2rw1xj13a67xbkzmndfh08iaqpcd";
  };

  prePatch = "patchShebangs .";

  patches = [
    ./static-gallium.patch
    ./dricore-gallium.patch
    ./fix-rounding.patch
  ];

  # Change the search path for EGL drivers from $drivers/* to driverLink
  postPatch = ''
    sed '/D_EGL_DRIVER_SEARCH_DIR=/s,EGL_DRIVER_INSTALL_DIR,${driverLink}/lib/egl,' \
      -i src/egl/main/Makefile.am
  '';

  preConfigure = "./autogen.sh";

  configureFlags = with stdenv.lib; [
    "--with-dri-searchpath=${driverLink}/lib/dri"

    "--enable-dri"
    "--enable-glx-tls"
    "--enable-shared-glapi" "--enable-shared-gallium"
    "--enable-driglx-direct" # seems enabled anyway
    "--enable-gallium-llvm" "--with-llvm-shared-libs"
    "--enable-xa" # used in vmware driver

    "--with-dri-drivers=i965,r200,radeon"
    "--with-gallium-drivers=i915,nouveau,r300,r600,svga,swrast" # radeonsi complains about R600 missing in LLVM
    "--with-egl-platforms=x11,wayland,drm" "--enable-gbm" "--enable-shared-glapi"
  ]
    ++ optional enableR600LlvmCompiler "--enable-r600-llvm-compiler" # complains about R600 missing in LLVM
    ++ optional enableTextureFloats "--enable-texture-float"
    ++ optionals enableExtraFeatures [
      "--enable-gles1" "--enable-gles2"
      "--enable-osmesa"
      "--enable-openvg" "--enable-gallium-egl" # not needed for EGL in Gallium, but OpenVG might be useful
      #"--enable-xvmc" # tests segfault with 9.1.{1,2,3}
      "--enable-vdpau"
      #"--enable-opencl" # ToDo: opencl seems to need libclc for clover
    ];

  nativeBuildInputs = [ pkgconfig python makedepend file flex bison ];

  propagatedBuildInputs = with xorg; [ libXdamage libXxf86vm ]
  ++
  stdenv.lib.optionals stdenv.isLinux [libdrm]
  ;
  buildInputs = with xorg; [
    autoconf automake libtool intltool expat libxml2Python llvm
    libXfixes glproto dri2proto libX11 libXext libxcb libXt
    libffi wayland
  ] ++ stdenv.lib.optionals enableExtraFeatures [ /*libXvMC*/ libvdpau ]
  ++ stdenv.lib.optional stdenv.isLinux [udev]
  ;

  enableParallelBuilding = true;
  doCheck = true;

  passthru = { inherit libdrm; inherit version; };

  meta = {
    description = "An open source implementation of OpenGL";
    homepage = http://www.mesa3d.org/;
    license = "bsd";
    platforms = stdenv.lib.platforms.mesaPlatforms;
    maintainers = [ stdenv.lib.maintainers.simons ];
  };
}
