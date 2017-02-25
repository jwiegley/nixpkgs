{ stdenv, lib, ghc, llvmPackages, packages, buildEnv, makeWrapper, runCommand
, ignoreCollisions ? false, withLLVM ? false
, postBuild ? ""
, haskellPackages
, ghcLibdir ? null
}:

# This wrapper works only with GHC 6.12 or later.
assert lib.versionOlder "6.12" ghc.version || ghc.isGhcjs;

# It's probably a good idea to include the library "ghc-paths" in the
# compiler environment, because we have a specially patched version of
# that package in Nix that honors these environment variables
#
#   NIX_GHC
#   NIX_GHCPKG
#   NIX_GHC_DOCDIR
#   NIX_GHC_LIBDIR
#
# instead of hard-coding the paths. The wrapper sets these variables
# appropriately to configure ghc-paths to point back to the wrapper
# instead of to the pristine GHC package, which doesn't know any of the
# additional libraries.
#
# A good way to import the environment set by the wrapper below into
# your shell is to add the following snippet to your ~/.bashrc:
#
#   if [ -e ~/.nix-profile/bin/ghc ]; then
#     eval $(grep export ~/.nix-profile/bin/ghc)
#   fi

let
  isGhcjs       = ghc.isGhcjs or false;
  ghc761OrLater = isGhcjs || lib.versionOlder "7.6.1" ghc.version;
  packageDBFlag = if ghc761OrLater then "--global-package-db" else "--global-conf";
  ghcCommand'    = if isGhcjs then "ghcjs" else "ghc";
  crossPrefix = if (ghc.cross or null) != null then "${ghc.cross.config}-" else "";
  ghcCommand = "${crossPrefix}${ghcCommand'}";
  ghcCommandCaps= lib.toUpper ghcCommand';
  libDir        = "$out/lib/${ghcCommand}-${ghc.version}";
  docDir        = "$out/share/doc/ghc/html";
  packageCfgDir = "${libDir}/package.conf.d";
  paths         = lib.filter (x: x ? isHaskellLibrary) (lib.closePropagation packages);
  hasLibraries  = lib.any (x: x.isHaskellLibrary) paths;
  # CLang is needed on Darwin for -fllvm to work:
  # https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/code-generators.html
  llvm          = lib.makeBinPath
                  ([ llvmPackages.llvm ]
                   ++ lib.optional stdenv.isDarwin llvmPackages.clang);
  ghcLibdirLink = runCommand "ghc_libdir" {} ''
    mkdir -p '${libDir}'
    echo '${ghcLibdir}' > '${libDir}/ghc_libdir_override'
  '';
in
if paths == [] && !withLLVM then ghc else
buildEnv {
  # this makes computing paths from the name attribute impossible;
  # if such a feature is needed, the real compiler name should be saved
  # as a dedicated drv attribute, like `compiler-name`
  name = ghc.name + "-with-packages";
  paths = paths ++ [ghc] ++ lib.optional (isGhcjs && ghcLibdir != null) ghcLibdirLink;
  extraOutputsToInstall = [ "out" "doc" ];
  inherit ignoreCollisions;
  postBuild = ''
    . ${makeWrapper}/nix-support/setup-hook

    # Work around buildEnv sometimes deciding to make bin a symlink
    if test -L "$out/bin"; then
      binTarget="$(readlink -f "$out/bin")"
      rm "$out/bin"
      cp -r "$binTarget" "$out/bin"
      chmod u+w "$out/bin"
    fi

    # wrap compiler executables with correct env variables

    for prg in ${ghcCommand} ${ghcCommand}i ${ghcCommand}-${ghc.version} ${ghcCommand}i-${ghc.version}; do
      if [[ -x "${ghc}/bin/$prg" ]]; then
        rm -f $out/bin/$prg
        makeWrapper ${ghc}/bin/$prg $out/bin/$prg                           \
          --add-flags '"-B$NIX_${ghcCommandCaps}_LIBDIR"'                   \
          --set "NIX_${ghcCommandCaps}"        "$out/bin/${ghcCommand}"     \
          --set "NIX_${ghcCommandCaps}PKG"     "$out/bin/${ghcCommand}-pkg" \
          --set "NIX_${ghcCommandCaps}_DOCDIR" "${docDir}"                  \
          --set "NIX_${ghcCommandCaps}_LIBDIR" "${libDir}"                  \
          ${lib.optionalString withLLVM ''--prefix "PATH" ":" "${llvm}"''}
      fi
    done

    for prg in runghc runhaskell; do
      if [[ -x "${ghc}/bin/$prg" ]]; then
        rm -f $out/bin/$prg
        makeWrapper ${ghc}/bin/$prg $out/bin/$prg                           \
          --add-flags "-f $out/bin/${ghcCommand}"                           \
          --set "NIX_${ghcCommandCaps}"        "$out/bin/${ghcCommand}"     \
          --set "NIX_${ghcCommandCaps}PKG"     "$out/bin/${ghcCommand}-pkg" \
          --set "NIX_${ghcCommandCaps}_DOCDIR" "${docDir}"                  \
          --set "NIX_${ghcCommandCaps}_LIBDIR" "${libDir}"
      fi
    done

    for prg in ${ghcCommand}-pkg ${ghcCommand}-pkg-${ghc.version}; do
      if [[ -x "${ghc}/bin/$prg" ]]; then
        rm -f $out/bin/$prg
        makeWrapper ${ghc}/bin/$prg $out/bin/$prg --add-flags "${packageDBFlag}=${packageCfgDir}"
      fi
    done

    ${lib.optionalString hasLibraries "$out/bin/${ghcCommand}-pkg recache"}
    ${lib.optionalString (isGhcjs && ghcLibdir != null) ''
      mv '${libDir}/ghc_libdir_override' '${libDir}/ghc_libdir'
    ''}
    $out/bin/${ghcCommand}-pkg check
  '' + postBuild;
  passthru = {
    preferLocalBuild = true;
    inherit (ghc) version meta;
    inherit haskellPackages;
  };
}
