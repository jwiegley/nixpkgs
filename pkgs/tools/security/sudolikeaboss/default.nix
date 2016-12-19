# This file was generated by go2nix, then modified by hand for Darwin support.
{ stdenv, buildGoPackage, fetchFromGitHub, fixDarwinDylibNames, darwin }:

buildGoPackage rec {
  name = "sudolikeaboss-unstable-${version}";
  version = "20161127-${stdenv.lib.strings.substring 0 7 rev}";
  rev = "2d9afe19f872c9f433d476e57ee86169781b164c";

  goPackagePath = "github.com/ravenac95/sudolikeaboss";

  src = fetchFromGitHub {
    owner = "ravenac95";
    repo = "sudolikeaboss";
    inherit rev;
    sha256 = "0ni3v4kanxfzxzjd48f5dgv62jbfrw7kdmq0snj09hw7ciw55yg6";
  };

  goDeps = ./deps.nix;

  propagatedBuildInputs = with darwin.apple_sdk.frameworks; [
    Cocoa
    fixDarwinDylibNames
  ];

  postInstall = ''
    install_name_tool -delete_rpath $out/lib -add_rpath $bin $bin/bin/sudolikeaboss
  '';

  meta = with stdenv.lib; {
    inherit version;
    inherit (src.meta) homepage;
    description = "Get 1password access from iterm2";
    license = licenses.mit;
    maintainers = [ maintainers.grahamc ];
    platforms = platforms.darwin;
  };
}
