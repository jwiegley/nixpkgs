{ stdenv, fetchurl, fetchgit, vdr, pkgconfig, gettext, ffmpeg_2, alsaLib, fetchFromGitHub
, libvdpau, libxcb, xcbutilwm, graphicsmagick, libav, pcre, xorgserver, ffmpeg, mesa_glu, mesa
, libiconv, boost, libgcrypt, perl, utillinux, groff, libva-full, xorg }:
{
  femon = stdenv.mkDerivation rec {
    name = "vdr-femon-2.2.1";
    buildInputs = [ vdr ];
    src = fetchurl {
      url = "http://www.saunalahti.fi/~rahrenbe/vdr/femon/files/${name}.tgz";
      sha256 = "f68913a795a6fdd36f39154ded51b2f7c1b85887dc5b5e2657030da80f291c00";
    };
    postPatch = "substituteInPlace Makefile --replace /bin/true true";
    makeFlags = [ "DESTDIR=$(out)" ];
    meta = with stdenv.lib; {
      homepage = http://www.saunalahti.fi/~rahrenbe/vdr/femon/;
      description = "DVB Frontend Status Monitor plugin for VDR";
      maintainers = [ maintainers.ck3d ];
      license = licenses.gpl2;
    };
  };

  softhddevice = stdenv.mkDerivation {
    name = "vdr-softhddevice-vpp-2017-11-09";

    buildInputs = [ vdr libxcb xcbutilwm ffmpeg ]
    ++ (with xorg; [ libxcb libX11 ])
    ++ [ alsaLib ]
    ++ [ libvdpau ] # vdpau
    ++ [ libva-full ] # va-api
    #    ++ [ mesa_glu mesa ] # va-api-glx
    ;

    makeFlags = [ "DESTDIR=$(out)" ];

    postPatch = ''
      substituteInPlace softhddev.c --replace /usr/bin/X ${xorgserver}/bin/X
    '';

    src = fetchFromGitHub {
      owner = "pesintta";
      repo = "vdr-plugin-softhddevice";
      sha256 = "06fm5mj83v95lpknhspz7glhl7qcc6b38l99wi3j9cvnlsk6dj63";
      rev = "d5fec7d5942ff0a5fa0b35f6f25480077873c158";
    };

    meta = with stdenv.lib; {
      homepage = https://github.com/pesintta/vdr-plugin-softhddevice;
      description = "VDR SoftHDDevice Plug-in (with VA-API VPP additions)";
      maintainers = [ maintainers.ck3d ];
      license = licenses.gpl2;
    };
  };


  markad = stdenv.mkDerivation rec {

    name = "vdr-markad-2017-03-13";

    src = fetchgit {
      url = "git://projects.vdr-developer.org/vdr-plugin-markad.git";
      sha256 = "0jvy70r8bcmbs7zdqilfz019z5xkz5c6rs57h1dsgv8v6x86c2i4";
      rev = "ea2e182ec798375f3830f8b794e7408576f139ad";
    };

    buildInputs = [ vdr libav ];

    postPatch = ''
      substituteInPlace command/Makefile --replace '$(DESTDIR)/usr' '$(DESTDIR)'

      substituteInPlace plugin/markad.cpp \
        --replace "/usr/bin" "$out/bin" \
        --replace "/var/lib/markad" "$out/var/lib/markad"

      substituteInPlace command/markad-standalone.cpp \
        --replace "/var/lib/markad" "$out/var/lib/markad"

      sed -i -e 's,^VDRDIR *=.*,VDRDIR = ${vdr.dev}/include/vdr,' \
        -e 's,^LIBDIR *=.*,LIBDIR = $(DESTDIR)/lib/vdr,' \
        -e 's,^LOCALEDIR *=.*,LOCALEDIR = $(DESTDIR)/share/locale,' plugin/Makefile
    '';

    preBuild = ''
      mkdir -p $out/lib/vdr
    '';

    buildFlags = [
      "DESTDIR=$(out)"
      "LIBDIR=$(out)/lib/vdr"
      "VDRDIR=${vdr.dev}/include/vdr"
    ];

    installFlags = buildFlags;

    meta = with stdenv.lib; {
      homepage = https://projects.vdr-developer.org/projects/plg-markad;
      description = "Ein Programm zum automatischen Setzen von Schnittmarken bei Werbeeinblendungen während einer Sendung.";
      maintainers = [ maintainers.ck3d ];
      license = licenses.gpl2;
    };

  };

  epgsearch = stdenv.mkDerivation rec {
    version = "2.2.0";

    name = "vdr-epgsearch-${version}";

    src = fetchurl {
      url = "https://projects.vdr-developer.org/git/vdr-plugin-epgsearch.git/snapshot/vdr-plugin-epgsearch-${version}.tar.bz2";
      sha256 = "0ba9vs40y6pml18f20ndw2sphkj2yrsvs67yzxksyf67m30nnmfz";
    };

    buildInputs = [
      vdr
      pcre
      perl # for pod2man and pos2html
      utillinux
      groff
    ];

    buildFlags = [
      "SENDMAIL="
      "REGEXLIB=pcre"
    ];

    installFlags = [
      "DESTDIR=$(out)"
    ];

    outputs = [ "out" "man" ];

    meta = with stdenv.lib; {
      homepage = http://winni.vdr-developer.org/epgsearch;
      description = "Searchtimer and replacement of the VDR program menu";
      maintainers = [ maintainers.ck3d ];
      license = licenses.gpl2;
    };
  };

  vnsiserver = let
    name = "vnsiserver";
    version = "1.5.1";
  in stdenv.mkDerivation {
    name = "vdr-${name}-${version}";
    buildInputs = [ vdr ];
    installFlags = [ "DESTDIR=$(out)" ];
    src = fetchgit {
      url = "https://github.com/FernetMenta/vdr-plugin-${name}.git";
      sha256 = "0yhyakqs71v1ygp27zm8y8sfxbm7mz8xg8xqh0gn1gmsznd8s791";
      rev = "refs/tags/v${version}";
    };
    meta = with stdenv.lib; {
      homepage = https://github.com/FernetMenta/vdr-plugin-vnsiserver;
      description = "VDR plugin to handle KODI clients.";
      maintainers = [ maintainers.ck3d ];
      license = licenses.gpl2;
    };
  };

  text2skin = stdenv.mkDerivation rec {

    name = "vdr-text2skin-1.3.4-2017-07-02";

    src = fetchgit {
      url = "git://projects.vdr-developer.org/vdr-plugin-text2skin.git";
      sha256 = "19hkwmaw6nwak38bv6cm2vcjjkf4w5yjyxb98qq6zfjjh5wq54aa";
      rev = "8f7954da2488ced734c30e7c2704b92a44e6e1ad";
    };

    buildInputs = [ vdr graphicsmagick ];

    buildFlags = [ "DESTDIR=$(out)" ];

    postPatch = ''
      sed -i Makefile \
        -e 's,IMAGELIB = imagemagick,IMAGELIB = graphicsmagic,' \
        -e 's,^VDRDIR *=.*,VDRDIR = ${vdr.dev}/include/vdr,' \
        -e 's,^LOCALEDIR *=.*,LOCALEDIR = $(DESTDIR)/share/locale,' \
        -e 's,^LIBDIR *=.*,LIBDIR = $(DESTDIR)/lib/vdr,'
    '';

    preBuild = ''
      mkdir -p $out/lib/vdr
    '';

    installPhase = "echo n/a";

    meta = with stdenv.lib; {
      homepage = https://projects.vdr-developer.org/projects/plg-text2skin;
      description = "VDR Text2Skin Plugin";
      maintainers = [ maintainers.ck3d ];
      license = licenses.gpl2;
    };
  };

  fritzbox = let
    libconvpp = stdenv.mkDerivation {
      name = "jowi24-libconv++-2013-02-16";
      propagatedBuildInputs = [ libiconv ];
      buildFlags = [ "CXXFLAGS=-std=c++11" ];
      src = fetchurl {
        url = "https://github.com/jowi24/libconvpp/archive/90769b2216bc66c5ea5e41a929236c20d367c63b.tar.gz";
        sha256 = "02q7mzif5967s1h2afrpsx1112qwn5ifapmcm190gfdr4hc6jag0";
      };
      installPhase = ''
        mkdir -p $out/lib $out/include/libconv++
        cp lib*.a $out/lib/libconv++.a
        cp *.h $out/include/libconv++
      '';
    };
    liblogpp = stdenv.mkDerivation {
      name = "jowi24-liblog++-2013-02-16";
      buildFlags = [ "CXXFLAGS=-std=c++11" ];
      src = fetchurl {
        url = "https://github.com/jowi24/liblogpp/archive/eee4046d2ae440974bcc8ceec00b069f0a2c62b9.tar.gz";
        sha256 = "1x4fw3x4a83hqhfjb942b3qzhvqbip3frdka113c9bhalvk32pcl";
      };
      installPhase = ''
        mkdir -p $out/lib $out/include/liblog++
        cp lib*.a $out/lib/liblog++.a
        cp *.h $out/include/liblog++
      '';
    };
    libnetpp = stdenv.mkDerivation {
      name = "jowi24-libnet++-2013-05-15";
      buildFlags = [ "CXXFLAGS=-std=c++11" ];
      src = fetchurl {
        url = "https://github.com/jowi24/libnetpp/archive/bb4387401c812b1b4a97bde7f365740a061677c7.tar.gz";
        sha256 = "1f7kcn4f08pjfl2n2y9zqzcs7m85rp5jc3c5rr1p89i0dw5v389s";
      };
      installPhase = ''
        mkdir -p $out/lib $out/include/libnet++
        cp lib*.a $out/lib/libnet++.a
        cp *.h $out/include/libnet++
      '';
      buildInputs = [ boost liblogpp libconvpp ];
    };
    libfritzpp = stdenv.mkDerivation {
      name = "jowi24-libfritz++-2013-12-01";
      buildFlags = [ "CXXFLAGS=-std=c++11" ];
      src = fetchurl {
        url = "https://github.com/jowi24/libfritzpp/archive/ca19013c9451cbac7a90155b486ea9959ced0f67.tar.gz";
        sha256 = "0gm7vzb95wad0xfm29gwv82j5xx6ym6zvpw77vzw59rx3ii2h55p";
      };
      installPhase = ''
        mkdir -p $out/lib $out/include/libfritz++
        cp lib*.a $out/lib/libfritz++.a
        cp *.h $out/include/libfritz++
      '';
      propagatedBuildInputs = [ libgcrypt ];
      buildInputs = [ boost liblogpp libconvpp libnetpp ];
    };
  in stdenv.mkDerivation {
    name = "vdr-fritzbox-1.5.3";
    src = fetchurl {
      url = "https://github.com/jowi24/vdr-fritz/archive/1.5.3.tar.gz";
      sha256 = "169k9micj1pdvnivb2m2swgzycs1kd0j8c8xska7j6l6y66f8mfh";
    };
    postUnpack = ''
      cp ${libfritzpp}/lib/* $sourceRoot/libfritz++
      cp ${liblogpp}/lib/* $sourceRoot/liblog++
      cp ${libnetpp}/lib/* $sourceRoot/libnet++
      cp ${libconvpp}/lib/* $sourceRoot/libconv++
    '';
    buildInputs = [ vdr boost libconvpp libfritzpp libnetpp liblogpp ];
    installFlags = [ "DESTDIR=$(out)" ];

    meta = with stdenv.lib; {
      homepage = https://github.com/jowi24/vdr-fritz;
      description = "A plugin for VDR to access AVMs Fritz Box routers";
      maintainers = [ maintainers.ck3d ];
      license = licenses.gpl2;
    };
  };
}

