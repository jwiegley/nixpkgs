{ stdenv, fetchurl
, attr, keyutils, libaio, libapparmor, libbsd, libcap, libgcrypt, lksctp-tools, zlib
}:

stdenv.mkDerivation rec {
  pname = "stress-ng";
  version = "0.10.00";

  src = fetchurl {
    url = "https://kernel.ubuntu.com/~cking/tarballs/${pname}/${pname}-${version}.tar.xz";
    sha256 = "0x602d9alilxxx2v59ryyg6s81l9nf8bxyavk5wf8jd5mshx57fh";
  };

  # All platforms inputs then Linux-only ones
  buildInputs = [ libbsd libgcrypt zlib ]
    ++ stdenv.lib.optionals stdenv.hostPlatform.isLinux [
      attr keyutils libaio libapparmor libcap lksctp-tools
    ];

  postPatch = ''
    substituteInPlace Makefile --replace "/usr" ""
  '';

  # Won't build on i686 because the binary will be linked again in the
  # install phase without checking the dependencies. This will prevent
  # triggering the rebuild. Why this only happens on i686 remains a
  # mystery, though. :-(
  enableParallelBuilding = (!stdenv.isi686);

  installFlags = [ "DESTDIR=${placeholder "out"}" ];

  meta = with stdenv.lib; {
    description = "Stress test a computer system";
    longDescription = ''
      stress-ng will stress test a computer system in various selectable ways. It
      was designed to exercise various physical subsystems of a computer as well as
      the various operating system kernel interfaces. Stress-ng features:

        * over 210 stress tests
        * over 50 CPU specific stress tests that exercise floating point, integer,
          bit manipulation and control flow
        * over 20 virtual memory stress tests
        * portable: builds on Linux, Solaris, *BSD, Minix, Android, MacOS X,
          Debian Hurd, Haiku, Windows Subsystem for Linux and SunOs/Dilos with
          gcc, clang, tcc and pcc.

      stress-ng was originally intended to make a machine work hard and trip hardware
      issues such as thermal overruns as well as operating system bugs that only
      occur when a system is being thrashed hard. Use stress-ng with caution as some
      of the tests can make a system run hot on poorly designed hardware and also can
      cause excessive system thrashing which may be difficult to stop.

      stress-ng can also measure test throughput rates; this can be useful to observe
      performance changes across different operating system releases or types of
      hardware. However, it has never been intended to be used as a precise benchmark
      test suite, so do NOT use it in this manner.
    '';
    homepage = "https://kernel.ubuntu.com/~cking/stress-ng/";
    downloadPage = "https://kernel.ubuntu.com/~cking/tarballs/stress-ng/";
    changelog = "https://kernel.ubuntu.com/git/cking/stress-ng.git/plain/debian/changelog?h=V${version}";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ c0bw3b ];
    platforms = platforms.unix;
  };
}
