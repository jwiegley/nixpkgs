x@{builderDefsPackage
  , yap, tcsh, perl, patchelf, pkgsi686Linux
  , ...}:
builderDefsPackage
(a :  
let 
  helperArgNames = ["stdenv" "fetchurl" "builderDefsPackage"] ++ 
    ["pkgsi686Linux"];

  buildInputs = map (n: builtins.getAttr n x)
    (builtins.attrNames (builtins.removeAttrs x helperArgNames));
  sourceInfo = rec {
    baseName="TPTP";
    version="6.0.0";
    name="${baseName}-${version}";
    urls=
    [
    "http://www.cs.miami.edu/~tptp/TPTP/Distribution/TPTP-v${version}.tgz"
    "http://www.cs.miami.edu/~tptp/TPTP/Archive/TPTP-v${version}/TPTP-v${version}.tgz"
    ];
    hash="0jnjkqdz937c7mkxvh9wc3byw5h1k19jss058fbzdxxc2hkwq1af";
  };
in
rec {
  src = a.fetchurl {
    urls = sourceInfo.urls;
    sha256 = sourceInfo.hash;
  };

  inherit (sourceInfo) name version;
  inherit buildInputs;

  /* doConfigure should be removed if not needed */
  phaseNames = ["goTarget" "doUnpack" "fixPlace" "setVars" "installScripts" 
    "patchBinaries" "makeLinks"];

  goTarget = a.fullDepEntry ''
    mkdir -p "$out"/share/
    cd "$out"/share/
  '' ["defEnsureDir" "minInit"];

  fixPlace = a.fullDepEntry ''
    cd ..
    mv TPTP-* tptp
    cd tptp
  '' ["minInit" "doUnpack"];

  setVars = a.noDepEntry ''
    export TPTP="$PWD"
  '';

  installScripts = a.fullDepEntry ''
    tcsh "$out/share/tptp/Scripts/tptp2T_install" -default

    sed -e 's@^ */bin/@@' -i TPTP2X/*

    tcsh "$out/share/tptp/TPTP2X/tptp2X_install" -default
  '' ["addInputs"];

  makeLinks = a.fullDepEntry ''
    mkdir -p "$out/bin"
    ln -s "../share/tptp/TPTP2X/tptp2X" "$out/bin"
    ln -s "../share/tptp/Scripts/tptp2T" "$out/bin"
    ln -s "../share/tptp/Scripts/tptp4X" "$out/bin"
  '' ["defEnsureDir" "minInit"];

  patchBinaries = a.fullDepEntry ''
    patchelf --set-interpreter "${pkgsi686Linux.glibc}"/lib/ld-linux.so.* \
      "Scripts/tptp4X"
  '' ["addInputs"];
      
  meta = {
    description = "Thousands of problems for theorem provers and tools";
    maintainers = with a.lib.maintainers;
    [
      raskin
    ];
    # A GiB of data. Installation is unpacking and editing a few files.
    # No sense in letting Hydra build it.
    # Also, it is unclear what is covered by "verbatim" - we will edit configs
    hydraPlatforms = [];
    license = "verbatim-redistribution";
  };
  passthru = {
    updateInfo = {
      downloadPage = "http://tptp.org/";
    };
  };
}) x

