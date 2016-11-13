{ stdenv, fetchurl, fixDarwinDylibNames }:

let
  pname = "icu4c";
  version = "57.1";
in
stdenv.mkDerivation ({
  name = pname + "-" + version;

  src = fetchurl {
    url = "http://download.icu-project.org/files/${pname}/${version}/${pname}-"
      + (stdenv.lib.replaceChars ["."] ["_"] version) + "-src.tgz";
    sha256 = "10cmkqigxh9f73y7q3p991q6j8pph0mrydgj11w1x6wlcp5ng37z";
  };

  outputs = [ "out" "dev" ];
  outputBin = "dev";

  # FIXME: This fixes dylib references in the dylibs themselves, but
  # not in the programs in $out/bin.
  buildInputs = stdenv.lib.optional stdenv.isDarwin fixDarwinDylibNames;

  postUnpack = ''
    sourceRoot=''${sourceRoot}/source
    echo Source root reset to ''${sourceRoot}
  '';

  preConfigure = ''
    sed -i -e "s|/bin/sh|${stdenv.shell}|" configure
  '';

  configureFlags = "--disable-debug" +
    stdenv.lib.optionalString (stdenv.isFreeBSD || stdenv.isDarwin) " --enable-rpath";

  # remove dependency on bootstrap-tools in early stdenv build
  postInstall = stdenv.lib.optionalString stdenv.isDarwin ''
    sed -i 's/INSTALL_CMD=.*install/INSTALL_CMD=install/' $out/lib/icu/${version}/pkgdata.inc
  '';

  postFixup = ''moveToOutput lib/icu "$dev" '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Unicode and globalization support library";
    homepage = http://site.icu-project.org/;
    maintainers = with maintainers; [ raskin urkud ];
    platforms = platforms.all;
  };
} // (if stdenv.isArm then {
  patches = [ ./0001-Disable-LDFLAGSICUDT-for-Linux.patch ];
} else {}))
