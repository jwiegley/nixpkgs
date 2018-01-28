{ stdenv
, fetchFromGitHub, fetchurl
, python

# for binding generation (untested)
, castxml ? null, pygccxml ? null

# for documentation
, doxygen ? null, graphviz ? null, imagemagick ? null

# for manual, tetex is used to get the eps2pdf binary
# texlive to get latexmk. building manual still fails though
, dia, tetex ? null, ghostscript ? null, texlive ? null

, enableDoxygen ? false

# e.g. "optimized" or "debug". If not set, use default one
, build_profile ? null

# --enable-examples
, withExamples ? false

# All modules can be enabled by choosing 'all_modules'.
# included here the DCE mandatory ones
, modules ? [ "core" "network" "internet" "point-to-point" "fd-net-device" "netanim"]
, gcc6
, lib
}:

let
  # there are various problems with manual generation see PR #31346
  # once those are solved, promote it to an option
  withManual = false;

  # required packages are not in mainline yet
  generateBindings = false;
in
stdenv.mkDerivation rec {

  name = "ns-3.${version}";
  version = "27.0";

  outputs = [ "out" ];

  # the all in one https://www.nsnam.org/release/ns-allinone-3.27.tar.bz2;
  # fetches everything (netanim etc), this package focuses ns3-core
  src = fetchFromGitHub {
    owner  = "nsnam";
    repo   = "ns-3-dev-git";
    rev    = "${name}";
    sha256 = "1w25qazsi4n35wzpxrfc1pdrid43gan3166c0bif196apras5phd";
  };

  buildInputs = lib.optionals generateBindings [ castxml pygccxml ]
    ++ stdenv.lib.optional enableDoxygen [ doxygen graphviz imagemagick python ]
    ++ stdenv.lib.optional withManual [ python.pkgs.sphinx dia tetex ghostscript
   texlive.combined.scheme-medium ];

  propagatedBuildInputs = [ gcc6 python ];

  postPatch = ''
    patchShebangs doc/ns3_html_theme/get_version.sh
  '';

  configureScript = "./waf configure";

  configureFlags = with stdenv.lib; [
      "--enable-modules=${stdenv.lib.concatStringsSep "," modules}"
      ]
      ++ optional (build_profile != null) "--build-profile=${build_profile}"
      ++ optional withExamples " --enable-examples "
      ++ optional doCheck " --enable-tests "
      ;

  postBuild = with stdenv.lib; let flags = concatStringsSep ";" (
       optional generateBindings "./waf --apiscan=all "
       ++ optional enableDoxygen "./waf doxygen"
       ++ optional withManual "./waf sphinx"
      );
      in "${flags}"
    ;

  doCheck = true;
  checkPhase =  ''
    ./test.py
    '';

  meta = {
    homepage = http://www.nsnam.org;
    license = stdenv.lib.licenses.gpl3;
    description = "A discrete time event network simulator";
    platforms = with stdenv.lib.platforms; unix;
  };
}
