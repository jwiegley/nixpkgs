{ stdenv, fetchurl }:

let
  fetchDB = src: name: sha256: fetchurl {
    inherit name sha256;
    url = "https://geolite.maxmind.com/download/geoip/database/${src}";
  };
in
stdenv.mkDerivation rec {
  name = "geolite-legacy-${version}";
  version = "2016-04-29";

  srcGeoIP = fetchDB
    "GeoLiteCountry/GeoIP.dat.gz" "GeoIP.dat.gz"
    "0g34nwilhim73f0qp0yq3lfx54c42wy70ra4dkmwlfddyq3ln0xd";
  srcGeoIPv6 = fetchDB
    "GeoIPv6.dat.gz" "GeoIPv6.dat.gz"
    "12k4nmfblm9c7kj4v7cyl6sgfgdfv2jdx4fl7nxfzpk1km7yc5na";
  srcGeoLiteCity = fetchDB
    "GeoLiteCity.dat.xz" "GeoIPCity.dat.xz"
    "04bi7zmmm7v9gl9vhxh0fvqfhmg9ja1lan4ff0njx7qs7lz3ak88";
  srcGeoLiteCityv6 = fetchDB
    "GeoLiteCityv6-beta/GeoLiteCityv6.dat.gz" "GeoIPCityv6.dat.gz"
    "1sr2yapsfmdpl4zpf8i5rl3k65dgbq7bb1615g6wf60yw9ngh76x";
  srcGeoIPASNum = fetchDB
    "asnum/GeoIPASNum.dat.gz" "GeoIPASNum.dat.gz"
    "1b7w8sdazxq5sv3nz1s28420374vf4wn6h2zasbg68kc2cxwdh2w";
  srcGeoIPASNumv6 = fetchDB
    "asnum/GeoIPASNumv6.dat.gz" "GeoIPASNumv6.dat.gz"
    "1iy6myanmx8h4ha493bz80q6wjwgjlbk7cmliyw1806dd7fhqvwi";

  meta = with stdenv.lib; {
    description = "GeoLite Legacy IP geolocation databases";
    homepage = https://geolite.maxmind.com/download/geoip;
    license = licenses.cc-by-sa-30;
    platforms = platforms.all;
    maintainers = with maintainers; [ nckx ];
  };

  builder = ./builder.sh;
}
