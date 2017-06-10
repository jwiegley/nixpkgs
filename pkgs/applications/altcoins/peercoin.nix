{ stdenv, fetchFromGitHub
, pkgconfig, autoreconfHook
, openssl, db48, boost, zlib, miniupnpc
, protobuf, utillinux, qt4, qrencode
, withGui, libevent }:

with stdenv.lib;
stdenv.mkDerivation rec {

  name = "peercoin" + (toString (optional (!withGui) "d")) + "-" + version;
  version = "0.5.4ppc";

  src = fetchFromGitHub {
    owner = "peercoin";
    repo = "peercoin";
    rev = "v${version}";
    sha256 = "17k4lxa2gdy5ir5q3l0d5y7wm8fhlyww7hakiqfvj05zgc49sxjj";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl db48 boost zlib
                  miniupnpc utillinux protobuf libevent ]
                  ++ optionals withGui [ qt4 qrencode ];

  configureFlags = [ "--with-boost-libdir=${boost.out}/lib" ]
                     ++ optionals withGui [ "--with-gui=qt4" ];

  buildPhase = ''
    qmake
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ppcoin-qt $out/bin/
  '';

  meta = {
    description = "A lite version of Bitcoin using scrypt as a proof-of-work algorithm";
    longDescription= ''
      Peercoin is a peer-to-peer Internet currency that enables instant payments
      to anyone in the world. It is based on the Bitcoin protocol but differs
      from Bitcoin in that it can be efficiently mined with consumer-grade hardware.
      Litecoin provides faster transaction confirmations (2.5 minutes on average)
      and uses a memory-hard, scrypt-based mining proof-of-work algorithm to target
      the regular computers and GPUs most people already have.
      The Litecoin network is scheduled to produce 84 million currency units.
    '';
    homepage = https://peercoin.org/;
    platforms = platforms.unix;
    license = licenses.mit;
    maintainers = with maintainers; [ offline AndersonTorres ];  
  };
}
