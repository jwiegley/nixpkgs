{ stdenv, fetchgit, openssl, doxygen, boost, sqlite, pkgconfig,
  python, pythonPackages, libpcap, ndn-cxx }:
let
  version = "2b7b83";
in
stdenv.mkDerivation {
  name = "ndn-tools-0.1-${version}";
  src = fetchgit {
    url = "https://github.com/named-data/repo-ng.git";
    rev = "2b7b83185868c727350ec2066f4cb18394dbfb1a";
    sha256 = "05zv7iyvv4bfqrvmw167h1gyfsfi6m140k2vik0qpcg2s3s0faik";
  };
  buildInputs = [ libpcap openssl doxygen boost sqlite pkgconfig
                  python pythonPackages.sphinx ndn-cxx ];
  preConfigure = ''
    patchShebangs waf
    ./waf configure \
      --boost-includes=${boost.dev}/include \
      --boost-libs=${boost.out}/lib \
      --with-tests \
      --prefix=$out
  '';
  buildPhase = ''
    ./waf
  '';
  # The tests can run but may fail. ~ C.
  doCheck = false;
  checkPhase = ''
    build/unit-tests
  '';
  installPhase = ''
    ./waf install
  '';
  # NB: Outputs not split because there's only binaries in the output. ~ C.
  meta = with stdenv.lib; {
    homepage = "http://named-data.net/";
    description = "Named Data Neworking (NDN) Repo";
    license = licenses.gpl3;
    platforms = stdenv.lib.platforms.unix;
    maintainers = [ maintainers.MostAwesomeDude ];
  };
}
