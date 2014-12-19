{ stdenv, fetchgit, autoconf, automake, libtool,
pkgconfig, perl, git, libevent, openssl}:

stdenv.mkDerivation {
  name = "libcouchbase-2.4.1";
  src = fetchgit {
    url = "https://github.com/couchbase/libcouchbase.git";
    rev = "bd3a20f9e18a69dca199134956fd4ad3e1b80ca8";
    sha256 = "1vqkf1a1fa6j3skyy5mwy0gapgh1mfh3gm1f7fr9ibkw1w3mbmv9";
    leaveDotGit = true;
  };

  preConfigure = ''
    patchShebangs ./config/
    ./config/autorun.sh
  '';

  configureFlags = "--disable-couchbasemock";

  buildInputs = [ autoconf automake libtool pkgconfig perl git libevent openssl];

  meta = {
    description = "C client library for Couchbase.";
    homepage = "https://github.com/couchbase/libcouchbase";
    license = stdenv.lib.licenses.asl20;
    platforms = stdenv.lib.platforms.unix;
  };
}