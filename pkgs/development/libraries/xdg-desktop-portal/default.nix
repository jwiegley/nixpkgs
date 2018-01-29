{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, flatpak, git, python3, glib }:

let
  version = "0.9";
in stdenv.mkDerivation rec {
  name = "xdg-desktop-portal-${version}";
  src = fetchFromGitHub {
    owner = "flatpak";
    repo = "xdg-desktop-portal";
    rev = version;
    sha256 = "14da38gxmy7shd6bjpc5xv3h93kz22l11cqrp7j8bgf08435fqjy";
  };

  nativeBuildInputs = [ autoreconfHook pkgconfig flatpak git python3 ];
  buildInputs = [ glib ];

  meta = with stdenv.lib; {
    description = "Desktop integration portals for sandboxed apps";
    maintainers = with maintainers; [ jtojnar ];
    platforms = platforms.linux;
    license = licenses.lgpl21;
  };
}
