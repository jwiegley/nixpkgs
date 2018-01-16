{ lib, stdenv, fetchFromGitHub, postgresql, python2, gnused }:

stdenv.mkDerivation rec {
  name = "libpqxx-6.0.0";

  src = fetchFromGitHub {
    owner = "jtv";
    repo = "libpqxx";
    rev = "6.0.0";
    sha256 = "1vg05n2vfx7gkrarjrdd837x5x270bf1zx6flyf53qdhbnnq92ax";
  };

  buildInputs = [ postgresql python2 gnused ];

  preConfigure = ''
    patchShebangs .
  '';

  configureFlags = "--enable-shared";

  meta = with lib; {
    description = "A C++ library to access PostgreSQL databases";
    homepage = http://pqxx.org/development/libpqxx/;
    license = lib.licenses.postgresql;
    platforms = with platforms; linux ++ darwin;
    maintainers = with maintainers; [ eelco periklis ];
  };
}
