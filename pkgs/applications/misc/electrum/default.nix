{ stdenv, fetchurl, pythonPackages
, enableTrezor ? false
, enableQt4 ? true
, enableTextUi ? false
}:

pythonPackages.buildPythonPackage rec {
  namePrefix = "";
  name = "electrum-${version}";
  version = "2.0.4";

  src = fetchurl {
    url = "https://download.electrum.org/Electrum-${version}.tar.gz";
    sha256 = "0q9vrrzy2iypfg2zvs3glzvqyq65dnwn1ijljvfqfwrkpvpp0zxp";
  };

  propagatedBuildInputs = with pythonPackages; [
    dns
    ecdsa
    pbkdf2
    protobuf
    pyasn1
    pyasn1-modules
    qrcode
    requests
    slowaes
    tlslite
  ]
  ++ stdenv.lib.optional enableTrezor trezor
  ++ stdenv.lib.optional enableQt4 pyqt4
  ++ stdenv.lib.optional enableTextUi python.modules.curses;

  preInstall = ''
    mkdir -p $out/share
    sed -i 's@usr_share = .*@usr_share = os.getenv("out")+"/share"@' setup.py
  '';

  meta = with stdenv.lib; {
    description = "Bitcoin thin-client";
    longDescription = ''
      An easy-to-use Bitcoin client featuring wallets generated from
      mnemonic seeds (in addition to other, more advanced, wallet options)
      and the ability to perform transactions without downloading a copy
      of the blockchain.
    '';
    homepage = https://electrum.org;
    license = licenses.gpl3;
    maintainers = with maintainers; [ emery joachifm ];
  };
}
