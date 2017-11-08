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
, withManual ? false

# to improve wifi precision
, withGsl ? false, gsl ? null

# e.g. "optimized" or "debug". If not set, use default one
, build_profile ? null

# --enable-examples
, withExamples ? false

, generateBindings ? false

# All modules can be enabled by choosing 'all_modules'.
# included here the DCE mandatory ones
, modules ? [ "core" "network" "internet" "point-to-point"]
, gcc6
, lib
}:

stdenv.mkDerivation rec {

  name = "ns-3.${version}";
  version = "27.0";

  outputs = [ "out" "doc" ];

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

  propagatedBuildInputs = with python.pythonPackages; [ gcc6 python ]
    ++ optional withGsl gsl
    ;

  postPatch = ''
    patchShebangs doc/ns3_html_theme/get_version.sh
  '';

  configureScript = "./waf configure";

  configureFlags = with stdenv.lib; [
      "--enable-modules=${stdenv.lib.concatStringsSep "," modules}"
      ]
      ++ optional build_profile "--build-profile=${build_profile}"
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
