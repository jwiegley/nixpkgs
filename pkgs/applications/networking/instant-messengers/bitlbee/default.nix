{ fetchurl, stdenv, gnutls, glib, pkgconfig, check, libotr, python }:

with stdenv.lib;
stdenv.mkDerivation rec {
  name = "bitlbee-3.4.1";

  src = fetchurl {
    url = "mirror://bitlbee/src/${name}.tar.gz";
    sha256 = "1qf0ypa9ba5jvsnpg9slmaran16hcc5fnfzbb1sdch1hjhchn2jh";
  };

  buildInputs = [ gnutls glib pkgconfig libotr python ]
    ++ optional doCheck check;

  configureFlags = [
    "--gcov=1"
    "--otr=1"
    "--ssl=gnutls"
  ];

  doCheck = true;

  meta = {
    description = "IRC instant messaging gateway";

    longDescription = ''
      BitlBee brings IM (instant messaging) to IRC clients.  It's a
      great solution for people who have an IRC client running all the
      time and don't want to run an additional MSN/AIM/whatever
      client.

      BitlBee currently supports the following IM networks/protocols:
      XMPP/Jabber (including Google Talk), MSN Messenger, Yahoo!
      Messenger, AIM and ICQ.
    '';

    homepage = http://www.bitlbee.org/;
    license = licenses.gpl2Plus;

    maintainers = with maintainers; [ wkennington pSub ];
    platforms = platforms.gnu;  # arbitrary choice
  };
}
