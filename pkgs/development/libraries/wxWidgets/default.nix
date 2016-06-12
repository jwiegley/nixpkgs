{ stdenv, fetchFromGitHub, pkgconfig, gtk, libXinerama, libSM, libXxf86vm, xf86vidmodeproto
, gstreamer, gst_plugins_base, GConf
, setfile ? null, Cocoa ? null, QuickTime ? null, Kernel ? null, QTKit ? null, rez ? null, derez ? null
, withMesa ? true, mesa ? null, unicode ? true
, compat28 ? false, compat30 ? false
, autoconf
}:

assert withMesa -> mesa != null;

with stdenv.lib;

let
  version = "3.1.0";
in
stdenv.mkDerivation {
  name = "wxwidgets-${version}";

  src = fetchFromGitHub {
    owner = "wxWidgets";
    repo = "wxWidgets";
    rev = "v${version}";
    sha256 = "14kl1rsngm70v3mbyv1mal15iz2b18k97avjx8jn7s81znha1c7f";
  };

  buildInputs =
    [ gtk libXinerama libSM libXxf86vm xf86vidmodeproto gstreamer
      gst_plugins_base GConf ]
    ++ optional withMesa mesa
    ++ optionals stdenv.isDarwin [ setfile rez derez ];

  propagatedBuildInputs = optionals stdenv.isDarwin [ Cocoa QuickTime Kernel QTKit ];

  nativeBuildInputs = [ pkgconfig autoconf ];

  patchPhase = if stdenv.isDarwin then ''
    substituteInPlace configure.in --replace "-framework System" -lSystem
    substituteInPlace build/aclocal/bakefile.m4 --replace /Developer/Tools/SetFile ${setfile}/bin/SetFile
  '' else "";

  preConfigure = "autoconf -B build/autoconf_prepend-include";

  configureFlags = [
    "--disable-precomp-headers"
    "--enable-compat28=${if compat28 then "yes" else "no"}"
    "--enable-compat30=${if compat30 then "yes" else "no"}"
    "--with-opengl=${if withMesa then "yes" else "no"}"
  ]
    ++ optional unicode "--enable-unicode"
    ++ optional stdenv.isDarwin "--with-cocoa";

  SEARCH_LIB = optionalString withMesa "${mesa}/lib";

  postInstall = "
    (cd $out/include && ln -s wx-*/* .)
  ";

  passthru = {inherit gtk compat30 compat28 unicode;};

  checkPhase = ''
    ./wx-config --libs
  '';

  doCheck = true;

  enableParallelBuilding = true;
  
  meta = {
    platforms = stdenv.lib.platforms.all;
  };
}
