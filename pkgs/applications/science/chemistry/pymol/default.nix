{ stdenv, fetchurl, makeDesktopItem
, python3, python3Packages
, glew, freeglut, libpng, libxml2, tk, freetype, libmsgpack }:


with stdenv.lib;

let
  pname = "pymol";
  ver_maj = "1.8";
  ver_min = "6";
  version = "${ver_maj}.${ver_min}.0";
  description = "A Python-enhanced molecular graphics tool";

  desktopItem = makeDesktopItem {
    name = "${pname}";
    exec = "${pname}";
    desktopName = "PyMol Molecular Graphics System";
    genericName = "Molecular Modeler";
    comment = description;
    mimeType = "chemical/x-pdb;chemical/x-mdl-molfile;chemical/x-mol2;chemical/seq-aa-fasta;chemical/seq-na-fasta;chemical/x-xyz;chemical/x-mdl-sdf;";
    categories = "Graphics;Education;Science;Chemistry;";
  };
in
python3Packages.buildPythonApplication {
  name = "pymol-${version}";
  src = fetchurl {
    url = "mirror://sourceforge/project/pymol/pymol/${ver_maj}/pymol-v${version}.tar.bz2";
    sha256 = "0rf5lcvwv41x2fbxdqfc0dj5n6v3nda13nqw55lhkgp1q45gkaky";
  };

  buildInputs = [ python3Packages.numpy glew freeglut libpng libxml2 tk freetype libmsgpack ];
  NIX_CFLAGS_COMPILE = "-I ${libxml2.dev}/include/libxml2";

  installPhase = ''
    python setup.py install --home=$out
    cp -r ${desktopItem}/share/ $out/
    runHook postInstall
  '';

  postInstall = with python3Packages; ''
    wrapProgram $out/bin/pymol \
      --prefix PYTHONPATH : ${makeSearchPathOutput "lib" python3.sitePackages [ Pmw tkinter ]}
  '';

  meta = {
    description = description;
    homepage = https://www.pymol.org/;
    license = licenses.psfl;
  };
}
