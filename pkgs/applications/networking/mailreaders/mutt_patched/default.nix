{ stdenv, fetchurl, fetchpatch, ncurses, which, perl, automake113x, autoconf
, sslSupport ? true
, imapSupport ? true
, headerCache ? true
, saslSupport ? true
, gpgmeSupport ? true
, gdbm ? null
, openssl ? null
, cyrus_sasl ? null
, gpgme ? null
}:

assert headerCache -> gdbm != null;
assert sslSupport -> openssl != null;
assert saslSupport -> cyrus_sasl != null;

let
  version = "1.5.23";
in
stdenv.mkDerivation rec {
  name = "mutt_patched-${version}";
  
  src = fetchurl {
    url = "mirror://sourceforge/mutt/mutt-${version}.tar.gz";
    sha256 = "0dzx4qk50pjfsb6cs5jahng96a52k12f7pm0sc78iqdrawg71w1s";
  };

  # Adding the sidebar
  # patches = [ ./sidebar.patch ];
  patches = [(fetchpatch {
    url = http://lunar-linux.org/~tchan/mutt/patch-1.5.23.sidebar.20140412.txt;
    sha256 = "0bq556sycl0qkr5vg5c3l16bh2bifqc2j7d64n4hw19q0ba2b45w";
  })];

  buildInputs = [
    ncurses which perl automake113x autoconf
    (if headerCache then gdbm else null)
    (if sslSupport then openssl else null)
    (if saslSupport then cyrus_sasl else null)
    (if gpgmeSupport then gpgme else null)
  ];
  
  configureFlags = [
    "--with-mailpath=" "--enable-smtp"

    # This allows calls with "-d N", that output debug info into ~/.muttdebug*
    "--enable-debug"

    "--enable-pop" "--enable-imap"

    # The next allows building mutt without having anything setgid
    # set by the installer, and removing the need for the group 'mail'
    # I set the value 'mailbox' because it is a default in the configure script
    "--with-homespool=mailbox"
    (if headerCache then "--enable-hcache" else "--disable-hcache")
    (if sslSupport then "--with-ssl" else "--without-ssl")
    (if imapSupport then "--enable-imap" else "--disable-imap")
    (if saslSupport then "--with-sasl" else "--without-sasl")
    (if gpgmeSupport then "--enable-gpgme" else "--disable-gpgme")
  ];

  meta = with stdenv.lib; {
    description = "A small but very powerful text-based mail client";
    homepage = http://www.mutt.org;
    license = "GPLv2+";
    platforms = platforms.unix;
    maintainers = with maintainers; [ the-kenny ];
  };
}

