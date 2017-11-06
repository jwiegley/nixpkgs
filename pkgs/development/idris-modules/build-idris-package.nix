# Build an idris package
#
# args: Additional arguments to pass to mkDerivation. Generally should include at least
#       name and src.
{ stdenv, idrisPackages, gmp }:
  { idrisDeps ? []
  , pkgName
  , version
  , src
  , meta
  , extraBuildInputs ? []
  , postPatch ? ""
  , postUnpack ? ""
  , doCheck ? true
  }:
let
  idris-with-packages = idrisPackages.with-packages (idrisDeps);
in
stdenv.mkDerivation ({

  name = "${pkgName}-${version}";

  postUnpack = postUnpack;


  # Some packages use the style
  # opts = -i ../../path/to/package
  # rather than the declarative pkgs attribute so we have to rewrite the path.
  postPatch = ''
    sed -i *.ipkg -e "/^opts/ s|-i \\.\\./|-i ${idris-with-packages}/libs/|g"
    cat *.ipkg
  '';

  src = src;

  buildPhase = ''
    ${idris-with-packages}/bin/idris --build *.ipkg
  '';

  doCheck = doCheck;

  checkPhase = ''
    if grep -q test *.ipkg; then
      ${idris-with-packages}/bin/idris --testpkg *.ipkg
    fi
  '';

  installPhase = ''
    ${idris-with-packages}/bin/idris --install *.ipkg --ibcsubdir $out/libs
  '';

  buildInputs = [ gmp ] ++ extraBuildInputs;

  propagatedBuildInputs = idrisDeps;

  meta = meta;
})
