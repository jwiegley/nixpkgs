{ stdenv, lib, fetchurl, copyPathsToStore
, hostPlatform
, pkgconfig, which
, zlib, bzip2, libpng, gnumake, glib

, # FreeType supports LCD filtering (colloquially referred to as sub-pixel rendering).
  # LCD filtering is also known as ClearType and covered by several Microsoft patents.
  # This option allows it to be disabled. See http://www.freetype.org/patents.html.
  useEncumberedCode ? true
}:

let
  inherit (stdenv.lib) optional optionals optionalString;
  version = "2.8.1"; name = "freetype-" + version;

in stdenv.mkDerivation {
  inherit name;

  meta = with stdenv.lib; {
    description = "A font rendering engine";
    longDescription = ''
      FreeType is a portable and efficient library for rendering fonts. It
      supports TrueType, Type 1, CFF fonts, and WOFF, PCF, FNT, BDF and PFR
      fonts. It has a bytecode interpreter and has an automatic hinter called
      autofit which can be used instead of hinting instructions included in
      fonts.
    '';
    homepage = https://www.freetype.org/;
    license = licenses.gpl2Plus; # or the FreeType License (BSD + advertising clause)
    platforms = platforms.all;
    maintainers = with maintainers; [ ttuegel ];
  };

  src = fetchurl {
    url = "mirror://savannah/freetype/${name}.tar.bz2";
    sha256 = "0y3xrimgp0k39gwq1vdi7b7wjy0z9fhwmzafisxqfardw015yhz5";
  };

  propagatedBuildInputs = [ zlib bzip2 libpng ]; # needed when linking against freetype
  # dependence on harfbuzz is looser than the reverse dependence
  nativeBuildInputs = [ pkgconfig which ]
    # FreeType requires GNU Make, which is not part of stdenv on FreeBSD.
    ++ optional (!stdenv.isLinux) gnumake;

  patches =
    [
      ./enable-table-validation.patch
    ] ++
    optional useEncumberedCode ./enable-subpixel-rendering.patch;

  outputs = [ "out" "dev" ];

  configureFlags = [ "--disable-static" "--bindir=$(dev)/bin" ];

  # The asm for armel is written with the 'asm' keyword.
  CFLAGS = optionalString stdenv.isArm "-std=gnu99";

  enableParallelBuilding = true;

  doCheck = true;

  postInstall = glib.flattenInclude;

  crossAttrs = stdenv.lib.optionalAttrs (hostPlatform.libc or null != "msvcrt") {
    # Somehow it calls the unwrapped gcc, "i686-pc-linux-gnu-gcc", instead
    # of gcc. I think it's due to the unwrapped gcc being in the PATH. I don't
    # know why it's on the PATH.
    configureFlags = "--disable-static CC_BUILD=gcc";
  };
}
