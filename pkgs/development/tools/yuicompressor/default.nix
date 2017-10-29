{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  name = "yuicompressor";
  version = "2.4.8";
  src = fetchurl {
    url = "http://github.com/yui/yuicompressor/releases/download/v${version}/${name}-${version}.jar";
    sha256 = "1qjxlak9hbl9zd3dl5ks0w4zx5z64wjsbk7ic73r1r45fasisdrh";
  };

  buildInputs = [makeWrapper jre];

  meta = {
    description = "A JavaScript and CSS minifier";
    maintainers = [ stdenv.lib.maintainers.jwiegley ];
    platforms = stdenv.lib.platforms.all;
    homepage = https://yui.github.io/yuicompressor/;
    license = stdenv.lib.licenses.bsd3;
  };

  buildCommand = ''
    mkdir -p $out/{bin,lib}
    ln -s $src $out/lib/yuicompressor.jar
    makeWrapper ${jre}/bin/java $out/bin/${name} --add-flags \
     "-cp $out/lib/yuicompressor.jar com.yahoo.platform.yui.compressor.YUICompressor"
  '';
}
