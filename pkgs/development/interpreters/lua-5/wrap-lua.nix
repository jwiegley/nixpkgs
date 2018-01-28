{ lib
, lua
, makeSetupHook
, makeWrapper }:

# is that used ?
with lib;

# defined in trivial-builders.nix
# imported as wrapLua in lua-packages.nix and pased to build-lua-derivation to be used as buildInput
makeSetupHook {
      deps = makeWrapper;
      # substitutions.executable = "${env}/bin/${lua}";
      substitutions.executable = lua.interpreter;
      substitutions.lua = lua;
      substitutions.luaversion = lua.majorVersion;


      # all the following is magicalSedExpression
      # substitutions.magicalSedExpression = let
      substitutions.magicalSedExpressionBAckup = let
        # Looks weird? Of course, it's between single quoted shell strings.
        # NOTE: Order DOES matter here, so single character quotes need to be
        #       at the last position.
        quoteVariants = [ "'\"'''\"'" "\"\"\"" "\"" "'\"'\"'" ]; # hey Vim: ''

        mkStringSkipper = labelNum: quote: let
          label = "q${toString labelNum}";
          isSingle = elem quote [ "\"" "'\"'\"'" ];
          endQuote = if isSingle then "[^\\\\]${quote}" else quote;
        in ''
          /^[a-z]?${quote}/ {
            /${quote}${quote}|${quote}.*${endQuote}/{n;br}
            :${label}; n; /^${quote}/{n;br}; /${endQuote}/{n;br}; b${label}
          }
        '';

        # This preamble does two things:
        # * Sets argv[0] to the original application's name; otherwise it would be .foo-wrapped.
        # * Adds all required libraries to sys.path via `site.addsitedir`. It also handles *.pth files.
          # export LUA_PATH="$program_LUA_PATH"
          # export LUA_CPATH="$program_LUA_CPATH"
        preamble = ''
          # sys.argv[0] = '"'$(readlink -f "$f")'"'
        '';

      in ''
        1 {
          :r
          /\\$|,$/{N;br}
          /__future__|^ |^ *(#.*)?$/{n;br}
          ${concatImapStrings mkStringSkipper quoteVariants}
          /^[^# ]/i ${replaceStrings ["\n"] [";"] preamble}
        }
      '';
} ./wrap.sh

