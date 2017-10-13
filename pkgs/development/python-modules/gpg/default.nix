{ stdenv, buildPythonPackage
, fetchPypi, libgpgerror, swig2
, gpgme
, withManpage ? true }:

buildPythonPackage rec {
  name = "gpg-${gpgme.version}";
  pname = "gpg";

  src = gpgme.src;

  # it could also run --cflags instead
  preConfigure = ''
    ./configure --enable-languages=python
    cd ${gpgme.pythonSourceRoot}
    substituteInPlace setup.py \
      --replace \
      'gpg_error_prefix = getconfig("prefix", config=gpg_error_config)[0]' \
      'gpg_error_prefix = "${libgpgerror.dev}"' \
      --replace \
      'gpgme_h = ""' \
      'gpgme_h = "${gpgme.dev}/include/gpgme.h"'
  '';

  buildInputs = [
    gpgme
    libgpgerror
    libgpgerror.dev
    gpgme
    swig2
  ];

  meta = with stdenv.lib; {
    homepage = https://www.gnupg.org;
    description = "GPG bindings for python";
    license = licenses.lgpl2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ teto ];
  };
}
