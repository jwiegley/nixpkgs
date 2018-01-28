{ stdenv, pkgs, fetchgit, pkgconfig, attr, libuuid, libscrypt, libsodium, keyutils, liburcu, zlib, libaio }:

stdenv.mkDerivation rec {
  name = "bcachefs-tools-unstable-2017-12-30";

  src = fetchgit {
    url = "https://evilpiepirate.org/git/bcachefs-tools.git";
    rev = "f8cbede6d18e81c804e62fd7d576310b420dcaac";
    sha256 = "1va6rh4pk4ky8wcddjcfqijhizs1bs8ib98i2v5d9yiwk1fildk6";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ attr libuuid libscrypt libsodium keyutils liburcu zlib libaio ];

  preConfigure = ''
    substituteInPlace cmd_migrate.c --replace /usr/include/dirent.h ${stdenv.lib.getDev stdenv.cc.libc}/include/dirent.h
  '';

  installFlags = [ "PREFIX=$(out)" ];

  meta = with stdenv.lib; {
    description = "Tool for managing bcachefs filesystems";
    homepage = http://bcachefs.org/;
    license = licenses.gpl2;
    maintainers = with maintainers; [ davidak ];
    platforms = platforms.linux;
  };
}
