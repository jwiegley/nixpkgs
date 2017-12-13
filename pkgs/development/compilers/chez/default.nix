{ stdenv, fetchgit, coreutils, cctools, ncurses, libiconv, libX11 }:

stdenv.mkDerivation rec {
  name    = "chez-scheme-${version}";
  version = "9.5-${dver}";
  dver    = "20171109";

  src = fetchgit {
    url    = "https://github.com/cisco/chezscheme.git";
    rev    = "bc117fd4d567a6863689fec6814882a0f04e577a";
    sha256 = "1adzw7bgdz0p4xmccc6awdkb7bp6xba9mnlsh3r3zvblqfci8i70";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ coreutils ] ++ stdenv.lib.optional stdenv.isDarwin cctools;

  buildInputs = [ ncurses libiconv libX11 ];

  /* We patch out a very annoying 'feature' in ./configure, which
  ** tries to use 'git' to update submodules.
  **
  ** We have to also fix a few occurrences to tools with absolute
  ** paths in some helper scripts, otherwise the build will fail on
  ** NixOS or in any chroot build.
  */
  patchPhase = ''
    substituteInPlace ./configure \
      --replace "git submodule init && git submodule update || exit 1" "true"

    substituteInPlace ./workarea \
      --replace "/bin/ln" ln \
      --replace "/bin/cp" cp

    substituteInPlace ./makefiles/installsh \
      --replace "/usr/bin/true" "${coreutils}/bin/true"

    substituteInPlace zlib/configure \
      --replace "/usr/bin/libtool" libtool
  '';

  /* Don't use configureFlags, since that just implicitly appends
  ** everything onto a --prefix flag, which ./configure gets very angry
  ** about.
  */
  configurePhase = ''
    ./configure --threads --installprefix=$out --installman=$out/share/man
  '';

  enableParallelBuilding = true;

  meta = {
    description = "A powerful and incredibly fast R6RS Scheme compiler";
    homepage    = "http://www.scheme.com";
    license     = stdenv.lib.licenses.asl20;
    platforms   = stdenv.lib.platforms.unix;
    maintainers = with stdenv.lib.maintainers; [ thoughtpolice ];
  };
}
