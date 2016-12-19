{stdenv, fetchurl, m4}:
stdenv.mkDerivation rec {
  name = "mpir-${version}";
  version = "2.7.2";
  buildInputs = [m4];
  src = fetchurl {
    url = "http://mpir.org/mpir-${version}.tar.bz2";
    sha256 = "1v25dx7cah2vxwzgq78hpzqkryrfxhwx3mcj3jjq3xxljlsw7m57";
  };
  meta = {
    inherit version;
    description = ''A highly optimised library for bignum arithmetic forked from GMP'';
    license = stdenv.lib.licenses.lgpl3Plus;
    maintainers = [stdenv.lib.maintainers.raskin];
    platforms = stdenv.lib.platforms.linux;
    downloadPage = "http://mpir.org/downloads.html";
    homepage = "http://mpir.org/";
    updateWalker = true;
  };
}
