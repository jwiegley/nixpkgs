{ stdenv, fetchurl, makeWrapper, python2Packages, bazaar }:

python2Packages.buildPythonApplication rec {
  name = "bzr-tools-${version}";
  version = "2.6.0";
  
  src = fetchurl {
    url = "http://launchpad.net/bzrtools/stable/${version}/+download/bzrtools-${version}.tar.gz";
    sha256 = "0n3zzc6jf5866kfhmrnya1vdr2ja137a45qrzsz8vz6sc6xgn5wb";
  };

  doCheck = false;

  meta = {
    description = "Bazaar plugins";
    homepage = http://wiki.bazaar.canonical.com/BzrTools;
    platforms = stdenv.lib.platforms.unix;
  };
}
