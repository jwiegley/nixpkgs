{ stdenv, buildPythonPackage, fetchFromGitHub
, future, six, ecdsa, pycryptodome
}:

buildPythonPackage rec {
  name = "python-jose-${version}";
  version = "1.3.2";
  src = fetchFromGitHub {
    owner = "mpdavis";
    repo = "python-jose";
    rev = version;
    sha256 = "0933pbflv2pvws5m0ksz8y1fqr8m123smmrbr5k9a71nssd502sv";
  };
  patches = [
    # to use pycryptodme instead of pycrypto
    ./pycryptodome.patch
  ];
  propagatedBuildInputs = [ future six ecdsa pycryptodome ];
  meta = {
    homepage = "https://github.com/mpdavis/python-jose";
    description = "A JOSE implementation in Python";
    platforms = stdenv.lib.platforms.all;
    license = stdenv.lib.licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ jhhuh ];
  };
}
