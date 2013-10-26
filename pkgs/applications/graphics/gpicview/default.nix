{ stdenv, fetchurl, intltool, pkgconfig, gtk2 }:

stdenv.mkDerivation {
  name = "gpicview-0.2.4";

  src = fetchurl {
    url    = "mirror://sourceforge/lxde/GPicView%20%28image%20Viewer%29/GpicView%200.2.4/gpicview-0.2.4.tar.gz";
    sha256 = "1svcy1c8bgk0pl12yhyv16h2fl52x5vzzcv57z6qdcv5czgvgglr";
  };

  meta = with stdenv.lib; {
    description = "A simple and fast image viewer for X";
    homepage    = http://lxde.sourceforge.net/gpicview/;
    license     = licenses.gpl2;
    maintainers = with maintainers; [ lovek323 ];
    platforms   = platforms.unix;
  };

  buildInputs = [ intltool pkgconfig gtk2 ];
}
