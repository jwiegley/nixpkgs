{ stdenv, lib, buildGoPackage, fetchgit }:

buildGoPackage rec {
  name = "mop-${version}";
  version = "0.2.0";
  rev = "bc666ec165d08b43134f7ec0bf29083ad5466243";

  goPackagePath = "github.com/michaeldv/mop";
  goDeps = ./deps.json;

  preConfigure = ''
    for i in $(find . -type f);do
        sed -i $i -e s/"michaeldv\/termbox-go"/"nsf\/termbox-go"/g
    done
    sed -i Makefile -e s/"mop\/cmd"/"mop\/mop"/g
    mv cmd mop
  '';

  src = fetchgit {
    inherit rev;
    url = "https://github.com/michaeldv/mop";
    sha256 = "0zp51g9i8rw6acs4vnrxclbxa5z1v0a0m1xx27szszp0rphcczkx";
  };

  meta = {
    description = "Simple stock tracker implemented in go";
    homepage =  https://github.com/mop-tracker/mop;
    platforms = stdenv.lib.platforms.all;
  };
}
