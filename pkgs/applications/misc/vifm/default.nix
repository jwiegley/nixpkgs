{ stdenv, fetchurl
, pkgconfig
, ncurses, libX11
, utillinux, file, which, mandoc
}:

stdenv.mkDerivation rec {
  name = "vifm-${version}";
  version = "0.8.2";

  src = fetchurl {
    url = "mirror://sourceforge/project/vifm/vifm/${name}.tar.bz2";
    sha256 = "07r15kq7kjl3a41sd11ncpsii866xxps4f90zh3lv8jqcrv6silb";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ ncurses libX11 utillinux file which mandoc ];

  meta = with stdenv.lib; {
    description = "A vi-like file manager";
    maintainers = with maintainers; [ raskin garbas ];
    platforms = platforms.linux;
    license = licenses.gpl2;
    downloadPage = "http://vifm.info/downloads.shtml";
    homepage = "http://vifm.info/";
    inherit version;
    updateWalker = true;
  };
}

