args: with args;
rec {
  version = "1.5.1";
  name = "moderncv-${version}";
  src = fetchurl {
    url = "https://launchpad.net/moderncv/trunk/${version}/+download/moderncv-${version}.zip";
    sha256 = "0y2m0qd0izrfjcwrmf3nvzkqmrhkdhzbv29s4c0knksdnfgcchc8";
  };

  buildInputs = [texLive unzip];
  phaseNames = ["doCopy"];
  doCopy = fullDepEntry (''
    mkdir -p $out/texmf-dist/tex/latex/moderncv $out/texmf-dist/doc $out/share
    mv *.cls *.sty $out/texmf-dist/tex/latex/moderncv/
    mv examples $out/texmf-dist/doc/moderncv
    ln -s $out/texmf* $out/share/
  '') ["minInit" "addInputs" "doUnpack" "defEnsureDir"];

  meta = {
    description = "the moderncv class for TeXLive";
    maintainers = [ args.lib.maintainers.simons ];

    # Actually, arch-independent..
    hydraPlatforms = [];
  };
}
