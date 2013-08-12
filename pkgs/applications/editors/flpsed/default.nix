{stdenv, fetchurl, fltk13, ghostscript}:

stdenv.mkDerivation {
  name = "flpsed-0.7.0";

  src = fetchurl {
    url = "http://www.ecademix.com/JohannesHofmann/flpsed-0.7.0.tar.gz";
    sha1 = "7966fd3b6fb3aa2a376386533ed4421ebb66ad62";
  };

  buildInputs = [ stdenv fltk13 ghostscript ];

  meta = {
    description = "A WYSIWYG PostScript annotator.";
    license = "GPL";
  };

}
