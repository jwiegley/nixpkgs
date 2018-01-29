{ stdenv, buildPythonPackage, python
, fetchPypi, libgpgerror, swig2
, gpgme
}:

buildPythonPackage rec {
  pname = "gpg";

  inherit (gpgme) src version;

  # it could also run --cflags instead
  # LDFLAGS="-L${python}/lib";
  # now fails with
#checking consistency of all components of python development environment... no
#configure: WARNING:
#  Could not link test program to Python. Maybe the main Python library has been
#  installed in some non-standard library path. If so, pass it to configure,
#  via the LDFLAGS environment variable.
#  Example: ./configure LDFLAGS="-L/usr/non-standard-path/python/lib"
#  ============================================================================
#   You probably have to install the development version of the Python package
#   for your distribution.  The exact name of this package varies among them.
#  ============================================================================


# cd ${gpgme}/lang/python
  preConfigure = ''
    ./configure --enable-languages=python LDFLAGS="-L${python}/lib"
    cd lang/python
    substituteInPlace setup.py \
      --replace \
      'gpg_error_prefix = getconfig("prefix", config=gpg_error_config)[0]' \
      'gpg_error_prefix = "${libgpgerror.dev}"' \
      --replace \
      'gpgme_h = ""' \
      'gpgme_h = "${gpgme.dev}/include/gpgme.h"'
  '';

  buildInputs = [
    libgpgerror
    libgpgerror.dev
    gpgme
    swig2
  ];

  doCheck=false;

  meta = with stdenv.lib; {
    homepage = https://www.gnupg.org;
    description = "GPG bindings for python";
    license = licenses.lgpl2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ teto ];
  };
}
