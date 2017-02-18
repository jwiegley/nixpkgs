{ stdenv, fetchurl, which, coq, coquelicot, flocq, mathcomp }:

stdenv.mkDerivation {
  name = "coq${coq.coq-version}-interval-3.1.1";

  src = fetchurl {
    url = https://gforge.inria.fr/frs/download.php/file/36342/interval-3.1.1.tar.gz;
    sha256 = "0jzkb0xykiz9bfaminy9yd88b5w0gxcpw506yaaqmnmb43gdksyf";
  };

  nativeBuildInputs = [ which ];
  buildInputs = [ coq ];
  propagatedBuildInputs = [ coquelicot flocq mathcomp ];

  configurePhase = "./configure --libdir=$out/lib/coq/${coq.coq-version}/user-contrib/Interval";
  buildPhase = "./remake";
  installPhase = "./remake install";

  meta = with stdenv.lib; {
    homepage = http://coq-interval.gforge.inria.fr/;
    description = "Tactics for simplifying the proofs of inequalities on expressions of real numbers for the Coq proof assistant";
    license = licenses.cecill-c;
    maintainers = with maintainers; [ vbgl ];
    platforms = coq.meta.platforms;
  };
}
