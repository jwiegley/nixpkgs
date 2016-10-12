{stdenv, fetchurl, pkgs, ocaml, lablgtk, fontschumachermisc, xset, makeWrapper, ncurses
, enableX11 ? true}:

let
  ocaml = pkgs.ocaml_4_02;
in
stdenv.mkDerivation (rec {

  name = "unison-2.48.4";
  src = fetchurl {
    url = "http://www.seas.upenn.edu/~bcpierce/unison/download/releases/stable/${name}.tar.gz";
    sha256 = "1s4xx5crswwq8hkzgalb5q5f5h8sz0ybw12g2203arqxcz6m7aih";
  };

  buildInputs = [ ocaml makeWrapper ncurses ];

  preBuild = if enableX11 then ''
    sed -i "s|\(OCAMLOPT=.*\)$|\1 -I $(echo "${lablgtk}"/lib/ocaml/*/site-lib/lablgtk2)|" Makefile.OCaml
  '' else "";

  makeFlags = "INSTALLDIR=$(out)/bin/" + (if enableX11 then " UISTYLE=gtk2" else "")
    + (if ! ocaml.nativeCompilers then " NATIVE=false" else "");

  preInstall = "mkdir -p $out/bin";

  postInstall = if enableX11 then ''
    for i in $(cd $out/bin && ls); do
      wrapProgram $out/bin/$i \
        --run "[ -n \"\$DISPLAY\" ] && (${xset}/bin/xset q | grep -q \"${fontschumachermisc}\" || ${xset}/bin/xset +fp \"${fontschumachermisc}/lib/X11/fonts/misc\")"
    done
  '' else "";

  dontStrip = !ocaml.nativeCompilers;

  meta = {
    homepage = http://www.cis.upenn.edu/~bcpierce/unison/;
    description = "Bidirectional file synchronizer";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.lib.maintainers; [viric];
    platforms = with stdenv.lib.platforms; linux;
  };

})
