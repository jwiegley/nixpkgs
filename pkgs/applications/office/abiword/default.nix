{ stdenv, fetchurl, pkgconfig, gtk3, libglade, libgnomecanvas, fribidi
, libpng, popt, libgsf, enchant, wv, librsvg, bzip2, libjpeg, perl
, boost, libxslt, goffice, makeWrapper, iconTheme
}:

stdenv.mkDerivation rec {
  name = "abiword-${version}";
  version = "3.0.2";

  src = fetchurl {
    url = "http://www.abisource.com/downloads/abiword/${version}/source/${name}.tar.gz";
    sha256 = "1ik591rx15nn3n1297cwykl8wvrlgj78i528id9wbidgy3xzd570";
  };

  enableParallelBuilding = true;

  patches = [
  (fetchurl { url = https://gist.githubusercontent.com/ylwghst/f65fef2a751e81af57e2d64d40128247/raw/; sha256 = "1ni2sc7jhqafwkkjdwchdx56fv7rp91grxblravp2kymrf9j1add"; })
  ];

  buildInputs =
    [ pkgconfig gtk3 libglade librsvg bzip2 libgnomecanvas fribidi libpng popt
      libgsf enchant wv libjpeg perl boost libxslt goffice makeWrapper iconTheme
    ];

  postFixup = ''
    wrapProgram "$out/bin/abiword" \
      --prefix XDG_DATA_DIRS : "$XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH"
  '';

  meta = with stdenv.lib; {
    description = "Word processing program, similar to Microsoft Word";
    homepage = http://www.abisource.com/;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ pSub ylwghst ];
  };
}
