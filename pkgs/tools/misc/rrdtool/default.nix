{ fetchFromGitHub, fetchpatch, stdenv, gettext, perl, pkgconfig, libxml2, pango, cairo, groff
, tcl-8_5, darwin }:

stdenv.mkDerivation rec {
  version = "1.7.0";
  name = "rrdtool-${version}.2017-06-11";

  src = fetchFromGitHub {
    owner = "oetiker";
    repo = "rrdtool-1.x";
    rev = "v${version}";
    sha256 = "1p8x717w4cgjcyr5kcd0s6vf1n94arif1w9pkbcl708j7gdi5gx1";
  };

  patches = [
    # fix regression https://github.com/oetiker/rrdtool-1.x/issues/794
    (fetchpatch {
      url = "https://github.com/oetiker/rrdtool-1.x/compare/0f28f99...f1edd12.patch";
      sha256 = "10g56zy0rdjpv3kvvmf6vvaysmla05wi8byy3l0xrz2x8m02ylqq";
    })
  ];

  nativeBuildInputs = [ pkgconfig ];

  buildInputs = [ gettext perl libxml2 pango cairo groff ]
    ++ stdenv.lib.optionals stdenv.isDarwin [ tcl-8_5 darwin.apple_sdk.frameworks.ApplicationServices ];

  postInstall = ''
    # for munin and rrdtool support
    mkdir -p $out/lib/perl5/site_perl/
    mv $out/lib/perl/5* $out/lib/perl5/site_perl/
  '';

  meta = with stdenv.lib; {
    homepage = http://oss.oetiker.ch/rrdtool/;
    description = "High performance logging in Round Robin Databases";
    license = licenses.gpl2;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ pSub ];
  };
}
