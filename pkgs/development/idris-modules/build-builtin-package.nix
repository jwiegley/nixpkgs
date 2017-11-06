# Build one of the packages that come with idris
# name: The name of the package
# deps: The dependencies of the package
{ idris, build-idris-package, lib }: name: deps:
let
  inherit (builtins.parseDrvName idris.name) version;
in
build-idris-package {


  pkgName = name;
  version = version;

  inherit (idris) src;

  idrisDeps = deps;

  postUnpack = ''
    sourceRoot=$sourceRoot/libs/${name}
  '';



  meta = idris.meta // {
    description = "${name} builtin Idris library";
  };
}
