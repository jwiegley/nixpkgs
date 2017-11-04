{ stdenv, fetchurl, fetchpatch, pkgconfig, gtk2, libXinerama, libSM, libXxf86vm, xf86vidmodeproto
, gstreamer, gst-plugins-base, GConf, setfile
, withMesa ? true, mesa_glu ? null, mesa_noglu ? null
, compat24 ? false, compat26 ? true, unicode ? true
, Carbon ? null, Cocoa ? null, Kernel ? null, QuickTime ? null, AGL ? null
}:

assert withMesa -> mesa_glu != null && mesa_noglu != null;

with stdenv.lib;

stdenv.mkDerivation rec {
  version = "2.9.4";
  name = "wxwidgets-${version}";

  src = fetchurl {
    url = "mirror://sourceforge/wxwindows/wxWidgets-${version}.tar.bz2";
    sha256 = "04jda4bns7cmp7xy68qz112yg0lribpc6xs5k9gilfqcyhshqlvc";
  };

  buildInputs =
    [ gtk2 libXinerama libSM libXxf86vm xf86vidmodeproto gstreamer
      gst-plugins-base GConf ]
    ++ optional withMesa mesa_glu
    ++ optionals stdenv.isDarwin [ setfile Carbon Cocoa Kernel QuickTime ];

  nativeBuildInputs = [ pkgconfig ];

  propagatedBuildInputs = optional stdenv.isDarwin AGL;

  patches = let
    fix17942 = fetchpatch {
      url = "https://trac.wxwidgets.org/attachment/ticket/17942/fix_assertion_using_hide_in_destroy.diff";
      sha256 = "1gi6xcq1m3n8ca1dg18mjz17jjrqyr75vvbjxm82dbv8b8gzqwhm";
    };
  in
  [
    "${fix17942}"
  ];

  configureFlags =
    [ "--enable-gtk2" "--disable-precomp-headers" "--enable-mediactrl"
      (if compat24 then "--enable-compat24" else "--disable-compat24")
      (if compat26 then "--enable-compat26" else "--disable-compat26") ]
    ++ optional unicode "--enable-unicode"
    ++ optional withMesa "--with-opengl"
    ++ optionals stdenv.isDarwin
      # allow building on 64-bit
      [ "--with-cocoa" "--enable-universal-binaries" "--with-macosx-version-min=10.7" ];

  SEARCH_LIB = "${mesa_glu.out}/lib ${mesa_noglu.out}/lib ";

  preConfigure = "
    substituteInPlace configure --replace 'SEARCH_INCLUDE=' 'DUMMY_SEARCH_INCLUDE='
    substituteInPlace configure --replace 'SEARCH_LIB=' 'DUMMY_SEARCH_LIB='
    substituteInPlace configure --replace /usr /no-such-path
  " + optionalString stdenv.isDarwin ''
    substituteInPlace configure --replace \
      'ac_cv_prog_SETFILE="/Developer/Tools/SetFile"' \
      'ac_cv_prog_SETFILE="${setfile}/bin/SetFile"'
    substituteInPlace configure --replace \
      "-framework System" \
      -lSystem
  '';

  postInstall = "
    (cd $out/include && ln -s wx-*/* .)
  ";

  passthru = {
    inherit compat24 compat26 unicode;
    gtk = gtk2;
  };

  enableParallelBuilding = true;

  meta = {
    platforms = with platforms; darwin ++ linux;
    license = licenses.wxWindows;
    homepage = https://www.wxwidgets.org/;
    description = "a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base";
    longDescription = "wxWidgets gives you a single, easy-to-use API for writing GUI applications on multiple platforms that still utilize the native platform's controls and utilities. Link with the appropriate library for your platform and compiler, and your application will adopt the look and feel appropriate to that platform. On top of great GUI functionality, wxWidgets gives you: online help, network programming, streams, clipboard and drag and drop, multithreading, image loading and saving in a variety of popular formats, database support, HTML viewing and printing, and much more.";
  };
}
