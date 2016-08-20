{ stdenv, fetchurl, ncurses, openssl, aspell, gnutls
, zlib, curl , pkgconfig, libgcrypt
, cmake, makeWrapper, libobjc, libiconv
, guileSupport ? true, guile
, luaSupport ? true, lua5
, perlSupport ? true, perl
, pythonPackages
, rubySupport ? true, ruby
, tclSupport ? true, tcl
, extraBuildInputs ? [] }:

assert guileSupport -> guile != null;
assert luaSupport -> lua5 != null;
assert perlSupport -> perl != null;
assert rubySupport -> ruby != null;
assert tclSupport -> tcl != null;

let
  inherit (pythonPackages) python pycrypto pync;
in

stdenv.mkDerivation rec {
  version = "1.5";
  name = "weechat-${version}";

  src = fetchurl {
    url = "http://weechat.org/files/src/weechat-${version}.tar.bz2";
    sha256 = "0n4cbhh9a7qq6y70ac9b4r0kb7hydwsic99h45ppr2jly322fvij";
  };

 cmakeFlags = {
    ENABLE_GUILE = guileSupport;
    ENABLE_LUA = luaSupport;
    ENABLE_PERL = perlSupport;
    ENABLE_RUBY = rubySupport;
    ENABLE_TCL = tclSupport;
  } // stdenv.lib.optionalAttrs stdenv.isDarwin {
    ICONV_LIBRARY = "${libiconv}/lib/libiconv.dylib";
  };

  buildInputs = with stdenv.lib; [
      ncurses python openssl aspell gnutls zlib curl pkgconfig
      libgcrypt pycrypto makeWrapper
      cmake
    ]
    ++ optionals stdenv.isDarwin [ pync libobjc ]
    ++ optional  guileSupport    guile
    ++ optional  luaSupport      lua5
    ++ optional  perlSupport     perl
    ++ optional  rubySupport     ruby
    ++ optional  tclSupport      tcl
    ++ extraBuildInputs;

  NIX_CFLAGS_COMPILE = "-I${python}/include/${python.libPrefix} -DCA_FILE=/etc/ssl/certs/ca-certificates.crt";

  postInstall = ''
    NIX_PYTHONPATH="$out/lib/${python.libPrefix}/site-packages"
    wrapProgram "$out/bin/weechat" \
      --prefix PYTHONPATH : "$PYTHONPATH" \
      --prefix PYTHONPATH : "$NIX_PYTHONPATH"
  '';

  meta = {
    homepage = http://www.weechat.org/;
    description = "A fast, light and extensible chat client";
    license = stdenv.lib.licenses.gpl3;
    maintainers = with stdenv.lib.maintainers; [ lovek323 garbas the-kenny ];
    platforms = stdenv.lib.platforms.unix;
  };
}
