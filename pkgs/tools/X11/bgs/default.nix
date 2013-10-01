{stdenv, fetchurl, libX11, libXinerama, imlib2}:

with stdenv.lib;

stdenv.mkDerivation rec {

  name = "bgs-${version}";
  version = "0.5";

  src = fetchurl {
    url = "https://github.com/Gottox/bgs/archive/${version}.tar.gz";
    sha256 = "67fe16e3483f30f940005856fbb3246e1f99cf58371470e0d6668a27acbaefb9";
  };

  buildInputs = [ libX11 libXinerama imlib2 ];

  preConfigure = [ ''sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk'' ];

  meta = { 
      description = "bgs is an extremely fast and small background setter for X.";
      license = "MIT";
      platforms = with stdenv.lib.platforms; all;
      maintainers = with stdenv.lib.maintainers; [pSub]; 
  };
}

