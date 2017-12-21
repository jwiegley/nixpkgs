{stdenv, fetchurl
, drmSupport ? false # Digital Radio Mondiale
, hdcSupport ? false # HD-Radio  
}:

with stdenv.lib;
stdenv.mkDerivation rec {
  name = "faad2-${version}";
  version = "2.7";

  src = fetchurl {
    url = "mirror://sourceforge/faac/${name}.tar.bz2";
    sha256 = "1db37ydb6mxhshbayvirm5vz6j361bjim4nkpwjyhmy4ddfinmhl";
  };

  patches = [ optional hdcSupport ./faad2-hdc-support.patch ];

  configureFlags = []
    ++ optional drmSupport "--with-drm"
    ++ optional hdcSupport "--with-hdc";

  meta = {
    description = "An open source MPEG-4 and MPEG-2 AAC decoder";
    homepage    = http://www.audiocoding.com/faad2.html;
    license     = licenses.gpl2;
    maintainers = with maintainers; [ codyopel ];
    platforms   = platforms.all;
  };
}
