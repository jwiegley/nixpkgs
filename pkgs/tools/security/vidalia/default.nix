{ stdenv, fetchurl, cmake, qt4, doxygen }:
stdenv.mkDerivation rec {

  name = "vidalia-${version}";
  version = "0.3.1";

  src = fetchurl {
    url = "https://www.torproject.org/dist/vidalia/${name}.tar.gz";
    sha256 = "1mw3wnlh18rj20qjv7jxjk3a8mf75p5wzv358qfs3sm3lqgd68qm";
  };

  buildInputs = [ cmake qt4 doxygen ];

  patches = [ 
    ./gcc-4.7.patch
    (fetchurl {
        name = "TorSettings.h.patch";
        url = "https://aur.archlinux.org/cgit/aur.git/plain/TorSettings.h.patch?h=vidalia";
        sha256 = "1yvgpq60mqschfawmc3l7l86w95mxc4nplj8rf7hh9z7xl9xcqii";
    })
  ];

  meta = with stdenv.lib; {
    homepage = https://www.torproject.org/projects/vidalia.html.en;
    repositories.git = https://git.torproject.org/vidalia;
    description = "A cross-platform graphical controller for the Tor software, built using the Qt framework";
    license = licenses.gpl2Plus;
    maintainers = [ maintainers.phreedom ];
    platforms = platforms.linux;
  };
}
