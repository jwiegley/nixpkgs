{ fetchurl, stdenv, cmake, fetchpatch }:

stdenv.mkDerivation rec {
  name = "cmocka-${version}";
  version = "1.0.1";

  src = fetchurl {
    url = "https://cmocka.org/files/1.0/cmocka-${version}.tar.xz";
    sha256 = "0fvm6rdalqcxckbddch8ycdw6n2ckldblv117n09chi2l7bm0q5k";
  };

  patches = [
    # This fixes the build for clang-3.7.0 and thus Darwin.
    # See https://open.cryptomilk.org/issues/43 for more info.
    #
    # The patch is already merged to upstream, so it should be removed
    # here on next release.
    (fetchpatch {
      url = "https://git.cryptomilk.org/projects/cmocka.git/patch/?id=1b595a80934fa95234fb290913cfe533f740d965";
      sha256 = "1fg8xwb1mrrmw4dqa65ghnvgfdkpi0lv4j2gq0lm9ayvsi3v00vp";
    })
  ];

  nativeBuildInputs = [ cmake ];

  meta = with stdenv.lib; {
    description = "Lightweight library to simplify and generalize unit tests for C";

    longDescription =
      ''There are a variety of C unit testing frameworks available however
        many of them are fairly complex and require the latest compiler
        technology.  Some development requires the use of old compilers which
        makes it difficult to use some unit testing frameworks. In addition
        many unit testing frameworks assume the code being tested is an
        application or module that is targeted to the same platform that will
        ultimately execute the test.  Because of this assumption many
        frameworks require the inclusion of standard C library headers in the
        code module being tested which may collide with the custom or
        incomplete implementation of the C library utilized by the code under
        test.

        Cmocka only requires a test application is linked with the standard C
        library which minimizes conflicts with standard C library headers.
        Also, CMocka tries to avoid the use of some of the newer features of
        C compilers.

        This results in CMocka being a relatively small library that can be
        used to test a variety of exotic code. If a developer wishes to
        simply test an application with the latest compiler then other unit
        testing frameworks may be preferable.

        This is the successor of Google's Cmockery.'';

    homepage = https://cmocka.org/;

    license = licenses.asl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ kragniz rasendubi ];
  };
}
