# This file was generated by https://github.com/kamilchm/go2nix v1.2.0
{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "browserpass-${version}";
  version = "1.0.6";

  goPackagePath = "github.com/dannyvankooten/browserpass";

  src = fetchFromGitHub {
    repo = "browserpass";
    owner = "dannyvankooten";
    rev = version;
    sha256 = "07wkvwb9klzxnlrm9a07kxzj3skpy0lymc9ijr8ykfbz6l0bpbqy";
  };

  postInstall = ''
      host_file="$bin/bin/browserpass"
      mkdir -p "$bin/etc"

      sed -e "s!%%replace%%!$host_file!" go/src/${goPackagePath}/chrome/host.json > chrome-host.json
      sed -e "s!%%replace%%!$host_file!" go/src/${goPackagePath}/firefox/host.json > firefox-host.json

      install chrome-host.json $bin/etc/
      install -D firefox-host.json $bin/lib/mozilla/native-messaging-hosts/com.dannyvankooten.browserpass.json
      install go/src/${goPackagePath}/chrome/policy.json $bin/etc/chrome-policy.json
  '';

  meta = with stdenv.lib; {
    description = "A Chrome & Firefox extension for zx2c4's pass";
    homepage = https://github.com/dannyvankooten/browserpass;
    license = licenses.mit;
    platforms = with platforms; linux ++ darwin ++ openbsd;
    maintainers = with maintainers; [ rvolosatovs ];
  };
}
