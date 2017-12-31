{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, flatpak, xdg-desktop-portal, gtk3, glib }:

let
  version = "0.9";
in stdenv.mkDerivation rec {
  name = "xdg-desktop-portal-gtk-${version}";
  src = fetchFromGitHub {
    owner = "flatpak";
    repo = "xdg-desktop-portal-gtk";
    rev = version;
    sha256 = "0n23wjwcqbm7792ff5df8acwpzc9qxpbib0kgqr1wmdmpiq3favh";
  };

  nativeBuildInputs = [ autoreconfHook pkgconfig flatpak xdg-desktop-portal ];
  buildInputs = [ glib gtk3 ];

  NIX_CFLAGS_COMPILE = "-I${glib.dev}/include/gio-unix-2.0";

  meta = with stdenv.lib; {
    description = "Desktop integration portals for sandboxed apps";
    maintainers = with maintainers; [ jtojnar ];
    platforms = platforms.linux;
    license = licenses.lgpl21;
  };
}
