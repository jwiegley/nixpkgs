{ stdenv, fetchurl, pkgconfig, openssl, db48, boost
, zlib, qt4, qmake4Hook, utillinux, protobuf, qrencode
, withGui }:

with stdenv.lib;
stdenv.mkDerivation rec{

  name = "primecoin" + (toString (optional (!withGui) "d")) + "-" + version;
  version = "0.8.6";

  src = fetchurl {
    url =  "https://github.com/primecoin/primecoin/archive/v${version}.tar.gz";
    sha256 = "0cixnkici74204s9d5iqj5sccib5a8dig2p2fp1axdjifpg787i3";
  };

  qmakeFlags = ["USE_UPNP=-"];
  makeFlags = ["USE_UPNP=-"];

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl db48 boost zlib utillinux protobuf ]
                  ++ optionals withGui [ qt4 qmake4Hook qrencode ];

  configureFlags = [ "--with-boost-libdir=${boost.out}/lib" ]
                     ++ optionals withGui [ "--with-gui=qt4" ];

  preBuild = "unset AR;"
              + (toString (optional (!withGui) "cd src; cp makefile.unix Makefile"));

  installPhase =
    if withGui
    then "install -D bitcoin-qt $out/bin/primecoin-qt"
    else "install -D bitcoind $out/bin/primecoind";

  # `make build/version.o`:
  # make: *** No rule to make target 'build/build.h', needed by 'build/version.o'.  Stop.
  enableParallelBuilding = false;

  meta = {
    description = "A new type cryptocurrency which is proof-of-work based on searching for prime numbers";
    longDescription= ''
      Primecoin is an innovative cryptocurrency, a form of digital
      currency secured by cryptography and issued through a
      decentralized mining market. Derived from Satoshi Nakamoto's
      Bitcoin, Primecoin introduces an unique form of proof-of-work
      based on prime numbers.

      The innovative prime proof-of-work in Primecoin not only
      provides security and minting to the network, but also generates
      a special form of prime number chains of interest to mathematical
      research. Thus primecoin network is energy-multiuse, compared to
      bitcoin.
    '';
    homepage = http://primecoin.io/;
    maintainers = with maintainers; [ AndersonTorres ];
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
