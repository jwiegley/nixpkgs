{ stdenv, python, buildEnv, makeWrapper
, extraLibs ? []
, extraOutputsToInstall ? []
, postBuild ? ""
, ignoreCollisions ? false
, requiredPythonModules
, }:

# Create a python executable that knows about additional packages.
let
  env = let
    paths = requiredPythonModules (extraLibs ++ [ python ] ) ;
  in buildEnv {
    name = "${python.name}-env";

    inherit paths;
    inherit ignoreCollisions;
    extraOutputsToInstall = [ "out" ] ++ extraOutputsToInstall;

    postBuild = ''
      . "${makeWrapper}/nix-support/setup-hook"

      if [ -L "$out/bin" ]; then
          unlink "$out/bin"
      fi
      mkdir -p "$out/bin"

      for path in ${stdenv.lib.concatStringsSep " " paths}; do
        if [ -d "$path/bin" ]; then
          cd "$path/bin"
          for prg in *; do
            if [ -f "$prg" ]; then
              rm -f "$out/bin/$prg"
              if [ -x "$prg" ]; then
                makeWrapper "$path/bin/$prg" "$out/bin/$prg" --set PYTHONHOME "$out" --set PYTHONNOUSERSITE "true"
              fi
            fi
          done
        fi
      done
    '' + postBuild;

    inherit (python) meta;

    passthru = python.passthru // {
      interpreter = "${env}/bin/${python.executable}";
      inherit python;
      env = stdenv.mkDerivation {
        name = "interactive-${python.name}-environment";
        nativeBuildInputs = [ env ];

        buildCommand = ''
          echo >&2 ""
          echo >&2 "*** Python 'env' attributes are intended for interactive nix-shell sessions, not for building! ***"
          echo >&2 ""
          exit 1
        '';
    };
    };
  };
in env
