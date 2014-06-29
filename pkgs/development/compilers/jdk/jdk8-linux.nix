{ swingSupport ? true
, stdenv
, requireFile
, unzip
, file
, xlibs ? null
, installjdk ? true
, pluginSupport ? true
, installjce ? false
, glib
, libxml2
, libav_0_8
, ffmpeg
, libxslt
, mesa_noglu
, freetype
, fontconfig
, gnome
, cairo
, alsaLib
, atk
, gdk_pixbuf
}:

assert stdenv.system == "i686-linux" || stdenv.system == "x86_64-linux";
assert swingSupport -> xlibs != null;

let

  /**
   * The JRE libraries are in directories that depend on the CPU.
   */
  architecture =
    if stdenv.system == "i686-linux" then
      "i386"
    else if stdenv.system == "x86_64-linux" then
      "amd64"
    else
      abort "jdk requires i686-linux or x86_64 linux";

  jce =
    if installjce then
      requireFile {
        name = "jce_policy-8.zip";
        url = http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html;
        sha256 = "f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59";
      }
    else
      "";
in

stdenv.mkDerivation rec {
  patchversion = "5";

  name =
    if installjdk then "jdk-1.8.0_${patchversion}" else "jre-1.8.0_${patchversion}";

  src =
    if stdenv.system == "i686-linux" then
      requireFile {
        name = "jdk-8u${patchversion}-linux-i586.tar.gz";
        url = http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html;
        sha256 = "779f83efb8dc9ce7c1143ba9bbd38fa2d8a1c49dcb61f7d36972d37d109c5fc9";
      }
    else if stdenv.system == "x86_64-linux" then

      requireFile {
        name = "jdk-8u${patchversion}-linux-x64.tar.gz";
        url = http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html;
        sha256 = "44901389e9fb118971534ad0f58558ba8c43f315b369117135bd6617ae631edc";
      }
    else
      abort "jdk requires i686-linux or x86_64 linux";

  nativeBuildInputs = [ file ]
    ++ stdenv.lib.optional installjce unzip;

  installPhase = ''
    cd ..

    # Set PaX markings
    exes=$(file $sourceRoot/bin/* $sourceRoot/jre/bin/* 2> /dev/null | grep -E 'ELF.*(executable|shared object)' | sed -e 's/: .*$//')
    for file in $exes; do
      paxmark m "$file"
      # On x86 for heap sizes over 700MB disable SEGMEXEC and PAGEEXEC as well.
      ${stdenv.lib.optionalString stdenv.isi686 ''paxmark msp "$file"''}
    done

    if test -z "$installjdk"; then
      mv $sourceRoot/jre $out
    else
      mv $sourceRoot $out
    fi

    for file in $out/*
    do
      if test -f $file ; then
        rm $file
      fi
    done

    if test -n "$installjdk"; then
      for file in $out/jre/*
      do
        if test -f $file ; then
          rm $file
        fi
      done
    fi

    # construct the rpath
    rpath=
    for i in $libraries; do
        rpath=$rpath''${rpath:+:}$i/lib''${rpath:+:}$i/lib64
    done

    if test -z "$installjdk"; then
      jrePath=$out
    else
      jrePath=$out/jre
    fi

    if test -n "${jce}"; then
      unzip ${jce}
      cp -v UnlimitedJCEPolicyJDK8/*.jar $jrePath/lib/security
    fi

    rpath=$rpath''${rpath:+:}$jrePath/lib/${architecture}/jli
    rpath=$rpath''${rpath:+:}$jrePath/lib/${architecture}/server
    rpath=$rpath''${rpath:+:}$jrePath/lib/${architecture}

    # set all the dynamic linkers
    find $out -type f -perm +100 \
        -exec patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
        --set-rpath "$rpath" {} \;

    find $out -name "*.so" -exec patchelf --set-rpath "$rpath" {} \;

    # HACK: For some reason, appending atk to the global patchelf rpath paths causes:
    #   java: relocation error: java: symbol , version GLIBC_2.2.5 not defined in file libc.so.6 with link time reference
    # Because only the libraries below need atk, we put it only in their rpath's.
    # This seems to work fine. When updating this, should this error occur again, try to remove jli or server from
    # the global patchelf rpath paths and if that works, use
    # nix-build $YOUR_LOCAL_CLONE -A oraclejdk8 -o jdk8
    # sudo find jdk8/ -type f | xargs ldd 2>/dev/null | grep -20 "not found"
    # to find any libraries that have unavailable dependencies and patch them in the same manner as shown below.
    # When updating you should also check with the above find-line whether there are libraries with
    # unavailable dependency on atk and if so add them to the below loop.
    for i in libglass \
             libprism_es2 \
             libprism_common \
             libjavafx_font \
             libjavafx_iio \
             libdecora_sse \
             libprism_sw \
             libjavafx_font_t2k \
             libjavafx_font_freetype \
             libjavafx_font_pango
    do
      test -f $out/jre/lib/${architecture}/"$i".so && patchelf --set-rpath "$rpath:${atk}/lib" $out/jre/lib/${architecture}/"$i".so
    done

    # HACK: Same as the above hack, but for xawt
    # Note: As of now, no binary or library seems to depend on xawt, but keep it around in case that changes in the future
    #for i in 
    #do
    #  test -f $out/jre/lib/${architecture}/"$i".so && patchelf --set-rpath "$rpath:$jrePath/lib/${architecture}/xawt" $out/jre/lib/${architecture}/"$i".so
    #done

    if test -z "$pluginSupport"; then
      rm -f $out/bin/javaws
      if test -n "$installjdk"; then
        rm -f $out/jre/bin/javaws
      fi
    fi

    mkdir $jrePath/lib/${architecture}/plugins
    ln -s $jrePath/lib/${architecture}/libnpjp2.so $jrePath/lib/${architecture}/plugins
  '';

  inherit installjdk pluginSupport;

  /**
   * libXt is only needed on amd64
   */
  libraries =
    [stdenv.gcc.libc glib libxml2 libav_0_8 ffmpeg libxslt mesa_noglu xlibs.libXxf86vm alsaLib fontconfig freetype gnome.pango gnome.gtk cairo gdk_pixbuf] ++
    (if swingSupport then [xlibs.libX11 xlibs.libXext xlibs.libXtst xlibs.libXi xlibs.libXp xlibs.libXt xlibs.libXrender stdenv.gcc.gcc] else []);

  passthru.mozillaPlugin = if installjdk then "/jre/lib/${architecture}/plugins" else "/lib/${architecture}/plugins";

  meta =
  {
    homepage = "http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html";
    description = "Java SE Development Kit 8 - The JDK is a development environment for building applications, applets, and components using the Java programming language";
    license = "unfree";
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.calrama ];
  };
}

