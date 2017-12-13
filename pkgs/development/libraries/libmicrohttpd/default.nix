{ stdenv, fetchurl, libgcrypt, curl, gnutls, pkgconfig, libiconv, libintlOrEmpty }:

stdenv.mkDerivation rec {
  name = "libmicrohttpd-${version}";
  version = "0.9.58";

  src = fetchurl {
    url = "mirror://gnu/libmicrohttpd/${name}.tar.gz";
    sha256 = "1wq17qvizis7bsyvyw1gnfycvivssncngziddnyrbzv2dhvy24bs";
  };

  outputs = [ "out" "dev" "devdoc" "info" ];
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libgcrypt curl gnutls ]
    ++ stdenv.lib.optionals stdenv.isDarwin [ libiconv libintlOrEmpty ];

  preCheck = ''
    # Since `localhost' can't be resolved in a chroot, work around it.
    sed -ie 's/localhost/127.0.0.1/g' src/test*/*.[ch]
  '';

  # Disabled because the tests can time-out.
  doCheck = false;

  meta = with stdenv.lib; {
    description = "Embeddable HTTP server library";

    longDescription = ''
      GNU libmicrohttpd is a small C library that is supposed to make
      it easy to run an HTTP server as part of another application.
    '';

    license = licenses.lgpl2Plus;

    homepage = http://www.gnu.org/software/libmicrohttpd/;

    maintainers = with maintainers; [ eelco vrthra fpletz ];
    platforms = platforms.unix;
  };
}

