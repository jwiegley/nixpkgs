{ stdenv, lua, buildEnv, makeWrapper
, extraLibs ? []
, postBuild ? ""
, ignoreCollisions ? false
, lib
, requiredLuaModules
}:

# Create a lua executable that knows about additional packages.
let
  env = let
    paths =  requiredLuaModules (extraLibs ++ [ lua ] );
  in buildEnv {
    name = "${lua.name}-env";

    inherit paths;
    inherit ignoreCollisions;

    # we create wrapper for the binaries in the different packages
    postBuild = ''

      . "${makeWrapper}/nix-support/setup-hook"

      # get access to lua functions
      . ${lua}/nix-support/setup-hook

      if [ -L "$out/bin" ]; then
          unlink "$out/bin"
      fi
      mkdir -p "$out/bin"

      addToLuaPath $out

      # take every binary from lua packages and put them into the env
      for path in ${stdenv.lib.concatStringsSep " " paths}; do
        echo "looking for binaries in path = $path"
        if [ -d "$path/bin" ]; then
          cd "$path/bin"
          for prg in *; do
            if [ -f "$prg" ]; then
              rm -f "$out/bin/$prg"
              if [ -x "$prg" ]; then
                echo "Making wrapper $prg"
                makeWrapper "$path/bin/$prg" "$out/bin/$prg" --suffix LUA_PATH ';' "$LUA_PATH"   --suffix LUA_CPATH ';' "$LUA_CPATH"
              fi
            fi
          done
        fi
      done
    '' + postBuild;

    inherit (lua) meta;

    passthru = lua.passthru // {
      interpreter = "${env}/bin/lua";
      inherit lua;
      env = stdenv.mkDerivation {
        name = "interactive-${lua.name}-environment";
        nativeBuildInputs = [ env ];

        buildCommand = ''
          echo >&2 ""
          echo >&2 "*** lua 'env' attributes are intended for interactive nix-shell sessions, not for building! ***"
          echo >&2 ""
          exit 1
        '';
    };
    };
  };
in env

