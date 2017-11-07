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

, withDoc ? false
, withManual ? false
, withGsl ? false

# --enable-examples
, withExamples ? false

# --enable-tests
, withTests ? true
, generateBindings ? false

# All modules can be enabled by choosing 'all_modules'.
# included here the DCE mandatory ones
, modules ? [ "core" "network" "internet" "point-to-point"]
, pkgs
, lib
}:

stdenv.mkDerivation rec {
  name = "ns-3.${version}";
  version = "27.0";

  # the all in one fetches netanim etc.
  # https://www.nsnam.org/release/ns-allinone-3.27.tar.bz2;
  src = fetchFromGitHub {
    owner  = "nsnam";
    repo   = "ns-3-dev-git";
    rev = "${name}";
    sha256 = "1w25qazsi4n35wzpxrfc1pdrid43gan3166c0bif196apras5phd";
  };

  buildInputs = lib.optionals generateBindings [ pkgs.castxml pygccxml ]
    ++ stdenv.lib.optional withDoc [ doxygen graphviz imagemagick python ]
    ++ stdenv.lib.optional withManual [ python.pkgs.sphinx dia tetex ghostscript
   texlive.combined.scheme-medium ];

  propagatedBuildInputs = with python.pythonPackages; with pkgs; [ gcc6 python ]
    ++ stdenv.lib.optional withGsl [ gsl-bin libgsl2 libgsl ]
    ;

  postPatch = ''
    patchShebangs doc/ns3_html_theme/get_version.sh
  '';

  configureScript = "./waf configure";

  configureFlags=[
      "--enable-modules=${stdenv.lib.concatStringsSep "," modules}"
      ]
      ++ stdenv.lib.optional withExamples " --enable-examples "
      ++ stdenv.lib.optional withTests " --enable-tests "
      ;

  postBuild = with stdenv.lib; let flags = concatStringsSep ";" (
       optional generateBindings "./waf --apiscan=all "
       ++ optional withDoc "./waf doxygen"
       ++ optional withManual "./waf sphinx"
      );
      in "${flags}"
    ;

  doCheck = withTests || withExamples;
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
