{ stdenv, fetchurl, pkgconfig, intltool, gtk, libxfce4util, libxfce4ui
, libwnck, xfconf, libglade, xfce4panel, thunar, exo, garcon, libnotify
, hicolor_icon_theme }:
let
  p_name  = "xfdesktop";
  ver_maj = "4.12";
  ver_min = "3";
in
stdenv.mkDerivation rec {
  name = "${p_name}-${ver_maj}.${ver_min}";

  src = fetchurl {
    url = "mirror://xfce/src/xfce/${p_name}/${ver_maj}/${name}.tar.bz2";
    sha256 = "a8a8d93744d842ca6ac1f9bd2c8789ee178937bca7e170e5239cbdbef30520ac";
  };

  buildInputs =
    [ pkgconfig intltool gtk libxfce4util libxfce4ui libwnck xfconf
      libglade xfce4panel thunar exo garcon libnotify hicolor_icon_theme
    ];

  patches =
    [
      (fetchpatch {
      url = https://git.xfce.org/xfce/xfdesktop/patch?id=157f5b55cfc3629d595ef38984278de5915aac27;
      sha256 = "07yvhci0yccbxnqymh2cf49j8yc0jsw147mnjzw9iy4kghj2rqxj";})
    ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = http://www.xfce.org/projects/xfdesktop;
    description = "Xfce desktop manager";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = [ maintainers.eelco ];
  };
}
