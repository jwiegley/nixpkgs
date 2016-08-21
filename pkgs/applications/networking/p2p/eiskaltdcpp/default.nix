{ stdenv, fetchurl, cmake, pkgconfig, qt4, boost, bzip2, libX11, pcre-cpp, libidn, lua5, miniupnpc, aspell, gettext }:

stdenv.mkDerivation rec {
  name = "eiskaltdcpp-2.2.9";

  src = fetchurl {
    url = "https://eiskaltdc.googlecode.com/files/${name}.tar.xz";
    sha256 = "3d9170645450f9cb0a605278b8646fec2110b9637910d86fd27cf245cbe24eaf";
  };

  buildInputs = [ cmake pkgconfig qt4 boost bzip2 libX11 pcre-cpp libidn lua5 miniupnpc aspell gettext ];

  cmakeFlags = {
    USE_ASPELL = true;
    USE_QT_QML = true;
    FREE_SPACE_BAR_C = true;
    USE_MINIUPNP = true;
    DBUS_NOTIFY = true;
    USE_JS = true;
    PERL_REGEX = true;
    USE_CLI_XMLRPC = true;
    WITH_SOUNDS = true;
    LUA_SCRIPT = true;
    WITH_LUASCRIPTS = true;
  };

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A cross-platform program that uses the Direct Connect and ADC protocols";
    homepage = https://code.google.com/p/eiskaltdc/;
    license = licenses.gpl3Plus;
    platforms = platforms.all;
  };
}
