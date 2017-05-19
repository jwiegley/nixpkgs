# This file was generated by https://github.com/kamilchm/go2nix v1.2.0
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "browserpass-${version}";
  version = "2017-04-11";
  rev = "e0fe250ed8fd061125746f5d99a1f9a678d21004";

  goPackagePath = "github.com/dannyvankooten/browserpass";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/dannyvankooten/browserpass";
    sha256 = "0khwlh5agdd2mm2yzklg8r2h084n8j7jbjjxsiaj67zm8zz6b39c";
  };

  postInstall = ''
      host_file="$bin/bin/browserpass"
      mkdir -p "$bin/etc"

      sed -e "s!%%replace%%!$host_file!" go/src/${goPackagePath}/chrome/host.json > chrome-host.json
      sed -e "s!%%replace%%!$host_file!" go/src/${goPackagePath}/firefox/host.json > firefox-host.json

      install -D chrome-host.json $bin/etc/chrome-host.json
      install -D firefox-host.json $bin/lib/mozilla/native-messaging-hosts/com.dannyvankooten.browserpass.json
  '';

  meta = {
    description = "A Chrome & Firefox extension for zx2c4's pass";
    homepage = "https://github.com/dannyvankooten/browserpass";
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.linux ++ stdenv.lib.platforms.darwin;
  };
}
