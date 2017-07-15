# This file was generated by go2nix.
{ stdenv, buildGoPackage, fetchFromGitHub
, gx
}:

buildGoPackage rec {
  name = "gx-go-${version}";
  version = "1.5.0";
  rev = "refs/tags/v${version}";

  goPackagePath = "github.com/whyrusleeping/gx-go";

  src = fetchFromGitHub {
    inherit rev;
    owner = "whyrusleeping";
    repo = "gx-go";
    sha256 = "0bg4h5lzs293qmlsr9n257vjpr5w6bxb4ampb25gsn3fgy3rvsis";
  };

  goDeps = ../deps.nix;

  extraSrcs = [
    {
      goPackagePath = gx.goPackagePath;
      src = gx.src;
    }
  ];

  meta = with stdenv.lib; {
    description = "A tool for importing go packages into gx";
    homepage = https://github.com/whyrusleeping/gx-go;
    license = licenses.mit;
    maintainers = with maintainers; [ zimbatm ];
  };
}
