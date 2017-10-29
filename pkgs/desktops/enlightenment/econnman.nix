{ stdenv, fetchurl, pkgconfig, efl, python2Packages, dbus, curl, makeWrapper }:

stdenv.mkDerivation rec {
  name = "econnman-${version}";
  version = "1.1";

  src = fetchurl {
    url = "http://download.enlightenment.org/rel/apps/econnman/${name}.tar.gz";
    sha256 = "057pwwavlvrrq26bncqnfrf449zzaim0zq717xv86av4n940gwv0";
  };

  nativeBuildInputs = [ makeWrapper pkgconfig python2Packages.wrapPython ];

  buildInputs = [ efl python2Packages.python dbus curl ];

  pythonPath = [ python2Packages.pythonefl python2Packages.dbus-python ];

  postInstall = ''
    wrapPythonPrograms
    wrapProgram $out/bin/econnman-bin --prefix LD_LIBRARY_PATH : ${curl.out}/lib
  '';

  meta = {
    description = "A user interface for the connman network connection manager";
    homepage = https://enlightenment.org/;
    maintainers = with stdenv.lib.maintainers; [ matejc tstrobel ftrvxmtrx ];
    platforms = stdenv.lib.platforms.linux;
    license = stdenv.lib.licenses.lgpl3;
  };
}
