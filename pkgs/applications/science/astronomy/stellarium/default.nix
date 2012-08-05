{stdenv, fetchurl, cmake, freetype, libpng, mesa, gettext, openssl, qt4, perl, libiconv}:

let
  name = "stellarium-0.11.3";
in
stdenv.mkDerivation {
  inherit name;

  src = fetchurl {
    url = "mirror://sourceforge/stellarium/${name}.tar.gz";
    sha256 = "f7c7eeaefcdc54c0fb8766f09e0c838acb742719adcdf12a6c1e12d55ecd6ac3";
  };

  buildInputs = [ cmake freetype libpng mesa gettext openssl qt4 perl libiconv ];

  preConfigure = ''
    sed -i -e '/typedef void (\*__GLXextFuncPtr)(void);/d' src/core/external/GLee.h
  '';

  enableParallelBuilding = true;

  meta = {
    description = "an free open source planetarium";
    homepage = http://stellarium.org/;
    license = "GPL2";

    platforms = stdenv.lib.platforms.linux; # should be mesaPlatforms, but we don't have qt on darwin
    maintainers = [ stdenv.lib.maintainers.simons ];
  };
}
