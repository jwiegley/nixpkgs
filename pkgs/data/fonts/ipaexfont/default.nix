{ stdenv, fetchzip }:

fetchzip rec {
  name = "ipaexfont-003.01";

  url = "http://dl.ipafont.ipa.go.jp/IPAexfont/IPAexfont00301.zip";

  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile \*.ttf -d $out/share/fonts/opentype
  '';

  sha256 = "02a6sj990cnig5lq0m54nmbmfkr3s57jpxl9fiyzrjmigvd1qmhj";

  meta = with stdenv.lib; {
    description = "Japanese font package with Mincho and Gothic fonts";
    longDescription = ''
      IPAex font is a Japanese font developed by the Information-technology
      Promotion Agency of Japan. It provides both Mincho and Gothic fonts,
      suitable for both display and printing.

      This is the successor to the IPA fonts.
    '';
    homepage = https://ipafont.ipa.go.jp/;
    license = licenses.ipa;
    maintainers = with maintainers; [ gebner ];
    platforms = with platforms; unix;
  };
}
