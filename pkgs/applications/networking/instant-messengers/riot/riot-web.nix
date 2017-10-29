{ stdenv, fetchurl, fetchpatch }:

stdenv.mkDerivation rec {
  name= "riot-web-${version}";
  version = "0.12.6";

  src = fetchurl {
    url = "https://github.com/vector-im/riot-web/releases/download/v${version}/riot-v${version}.tar.gz";
    sha256 = "00hxjhnsm4622hv46xm7lc81kbnzi2iz77qppwma14cbh63jbilv";
  };

  installPhase = ''
    mkdir -p $out/
    cp -R . $out/
  '';

  meta = {
    description = "A glossy Matrix collaboration client for the web";
    homepage = https://riot.im/;
    maintainers = with stdenv.lib.maintainers; [ bachp ];
    license = stdenv.lib.licenses.asl20;
    platforms = stdenv.lib.platforms.all;
    hydraPlatforms = [];
  };
}
