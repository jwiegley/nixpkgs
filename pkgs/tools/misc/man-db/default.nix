{ stdenv, fetchurl, pkgconfig, libpipeline, db, groff }:

stdenv.mkDerivation rec {
  name = "man-db-2.7.5";

  src = fetchurl {
    url = "mirror://savannah/man-db/${name}.tar.xz";
    sha256 = "056a3il7agfazac12yggcg4gf412yq34k065im0cpfxbcw6xskaw";
  };

  preConfigure = stdenv.lib.optional stdenv.isDarwin ''
    export CFLAGS="-Wl,-flat_namespace,-undefined,suppress -Iwindows.h"
  '';

  postConfigure = stdenv.lib.optional stdenv.isDarwin ''
    # Check for posix_fadvise might return false positive.
    sed -e 's|#define HAVE_POSIX_FADVISE 1|/* #undef HAVE_POSIX_FADVISE */|' -i config.h
  '';

  patches = stdenv.lib.optional stdenv.isDarwin ./darwin-add-windows-include.patch;

  outputs = [ "out" "doc" ];
  outputMan = "out"; # users will want `man man` to work

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libpipeline db groff ];

  configureFlags = [
    "--disable-setuid"
    "--localstatedir=/var"
    # Don't try /etc/man_db.conf by default, so we avoid error messages.
    "--with-config-file=\${out}/etc/man_db.conf"
    "--with-systemdtmpfilesdir=\${out}/lib/tmpfiles.d"
    "--with-eqn=${groff}/bin/eqn"
    "--with-neqn=${groff}/bin/neqn"
    "--with-nroff=${groff}/bin/nroff"
    "--with-pic=${groff}/bin/pic"
    "--with-refer=${groff}/bin/refer"
    "--with-tbl=${groff}/bin/tbl"
  ];

  enableParallelBuilding = true;

  doCheck = ! stdenv.isDarwin;

  meta = with stdenv.lib; {
    homepage = "http://man-db.nongnu.org";
    description = "An implementation of the standard Unix documentation system accessed using the man command";
    license = licenses.gpl2;
    platforms = platforms.unix;
  };
}
