{ stdenv, fetchFromGitHub, pkgconfig, ncurses, readline }:

stdenv.mkDerivation rec {
  version = "0.2.9";
  name = "yaft-${version}";

  src = fetchFromGitHub {
    owner = "uobikiemukot";
    repo = "yaft";
    rev = "v${version}";
    sha256 = "0l1ig8wm545kpn4l7186rymny83jkahnjim290wsl7hsszfq1ckd";
  };

  installPhase = ''
    mkdir -p $out/{bin,share/man}
    DESTDIR=$out PREFIX=$out/bin/ MANPREFIX=$out/share/man/
  '';

  meta = {
    homepage = "https://github.com/uobikiemukot/yaft";
    description = "yet another framebuffer terminal";
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.matthiasbeyer ];
    platforms = with stdenv.lib.platforms; linux;
  };
}
