{ stdenv, fetchgit, emacs, texinfo, texLive, perl, which, automake, enableDoc ? false }:

stdenv.mkDerivation (rec {
  name = "ProofGeneral-HEAD";

  src = fetchgit {
    url = "https://github.com/ProofGeneral/PG.git";
    rev = "64ca55b1593fff8cfffab89c51d7e92c1a68dc27";
    sha256 = "1gz13fagxf0w2zgp7qd0w328qiv97295jwq7ra8vj61pdfi8xklj";
  };

  buildInputs = [ emacs texinfo perl which ] ++ stdenv.lib.optional enableDoc texLive;

  prePatch =
    '' sed -i "Makefile" \
           -e "s|^\(\(DEST_\)\?PREFIX\)=.*$|\1=$out|g ; \
               s|/sbin/install-info|install-info|g"


       sed -i "bin/proofgeneral" -e's/which/type -p/g'

       # @image{ProofGeneral} fails, so remove it.
       sed -i '94d' doc/PG-adapting.texi
       sed -i '96d' doc/ProofGeneral.texi
    '';

  patches = [ ./pg.patch ];

  preBuild = ''
    make clean;
  '';

  installPhase =
    if enableDoc
    then
    # Copy `texinfo.tex' in the right place so that `texi2pdf' works.
    '' cp -v "${automake}/share/"automake-*/texinfo.tex doc
       make install install-doc
    ''
    else "make install";

  meta = {
    description = "Proof General, an Emacs front-end for proof assistants";
    longDescription = ''
      Proof General is a generic front-end for proof assistants (also known as
      interactive theorem provers), based on the customizable text editor Emacs.
    '';
    homepage = http://proofgeneral.inf.ed.ac.uk;
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = stdenv.lib.platforms.unix;  # arbitrary choice
  };
})
