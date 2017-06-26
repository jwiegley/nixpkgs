{ stdenv, fetchgit, doxygen, boost, pkgconfig, python, pythonPackages,
  libpcap, openssl, ndn-cxx }:
let
  version = "0.5.1";
in
stdenv.mkDerivation {
  name = "nfd-${version}";
  src = fetchgit {
    url = "https://github.com/named-data/NFD.git";
    rev = "19e2e6d85890a037fd493d0415dbdd5bfc186241";
    sha256 = "1fx479ybc4ldz0k8fg4d7b51wb0qdvl9q0rw3b2cc30b1dnr2awx";
  };
  buildInputs = [ libpcap doxygen boost pkgconfig python pythonPackages.sphinx
                  openssl ndn-cxx ];
  preConfigure = ''
    patchShebangs waf
    ./waf configure \
      --boost-includes=${boost.dev}/include \
      --boost-libs=${boost.out}/lib \
      --prefix=$out
  '';
  buildPhase = ''
    ./waf
  '';
  installPhase = ''
    ./waf install
  '';
  # Even though there are binaries, they don't get put in "bin" by default, so
  # this ordering seems to be a better one. ~ C.
  outputs = [ "out" "dev" "doc" ];
  meta = with stdenv.lib; {
    homepage = "http://named-data.net/";
    description = "Named Data Neworking (NDN) Forwarding Daemon";
    license = licenses.gpl3;
    platforms = stdenv.lib.platforms.unix;
    maintainers = [ maintainers.MostAwesomeDude ];
  };
}
