{ stdenv
, lib
, fetchurl
, alsaLib
, atk
, bzip2
, cairo
, curl
, expat
, fontconfig
, freetype
, gdk_pixbuf
, glib
, glibc
, graphite2
, gtk2
, harfbuzz
, libICE
, libSM
, libX11
, libXau
, libXcomposite
, libXcursor
, libXdamage
, libXdmcp
, libXext
, libXfixes
, libXi
, libXinerama
, libXrandr
, libXrender
, libXt
, libXxf86vm
, libdrm
, libffi
, libpng
, libvdpau
, libxcb
, libxshmfence
, nspr
, nss
, pango
, pcre
, pixman
, zlib
, unzip
, debug ? false
}:

let
  arch =
    if stdenv.system == "x86_64-linux" then
      "x86_64"
    else throw "Flash Player is not supported on this platform";
in
stdenv.mkDerivation rec {
  name = "flashplayer-standalone-${version}";
  version = "28.0.0.126";

  src = fetchurl {
    url =
      if debug then
        "https://fpdownload.macromedia.com/pub/flashplayer/updaters/28/flash_player_sa_linux_debug.x86_64.tar.gz"
      else
        "https://fpdownload.macromedia.com/pub/flashplayer/updaters/28/flash_player_sa_linux.x86_64.tar.gz";
    sha256 =
      if debug then
        "07692qivf09zh36vlaczwwq93f8p7v1afnsgkry7m9yybxh1753d"
      else
        "14xj55wjp9jvm01n8bwrbwmkhpcrxc44yfqi3jq8f8pzrqi7smck";
  };

  nativeBuildInputs = [ unzip ];

  sourceRoot = ".";

  dontStrip = true;
  dontPatchELF = true;

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -pv flashplayer${lib.optionalString debug "debugger"} $out/bin

    patchelf \
      --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      --set-rpath "$rpath" \
      $out/bin/flashplayer${lib.optionalString debug "debugger"}
  '';

  rpath = lib.makeLibraryPath
    [ stdenv.cc.cc
      alsaLib atk bzip2 cairo curl expat fontconfig freetype gdk_pixbuf glib
      glibc graphite2 gtk2 harfbuzz libICE libSM libX11 libXau libXcomposite
      libXcursor libXdamage libXdmcp libXext libXfixes libXi libXinerama
      libXrandr libXrender libXt libXxf86vm libdrm libffi libpng libvdpau
      libxcb libxshmfence nspr nss pango pcre pixman zlib
    ];

  meta = {
    description = "Adobe Flash Player standalone executable";
    homepage = https://www.adobe.com/support/flashplayer/debug_downloads.html;
    license = stdenv.lib.licenses.unfree;
    maintainers = [];
    platforms = [ "x86_64-linux" ];
  };
}
