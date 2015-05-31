{ system ? builtins.currentSystem }:

with import ../../top-level/all-packages.nix {inherit system;};

rec {

  build =

    stdenv.mkDerivation {
      name = "build";

      buildInputs = [nukeReferences cpio];

      buildCommand = ''
        set -x
        mkdir -p $out/bin $out/lib $out/libexec

        # Copy what we need of Glibc.
        cp -d ${glibc}/lib/ld*.so* $out/lib
        cp -d ${glibc}/lib/libc*.so* $out/lib
        cp -d ${glibc}/lib/libc_nonshared.a $out/lib
        cp -d ${glibc}/lib/libm*.so* $out/lib
        cp -d ${glibc}/lib/libdl*.so* $out/lib
        cp -d ${glibc}/lib/librt*.so*  $out/lib
        cp -d ${glibc}/lib/libpthread*.so* $out/lib
        cp -d ${glibc}/lib/libnsl*.so* $out/lib
        cp -d ${glibc}/lib/libutil*.so* $out/lib
        cp -d ${glibc}/lib/libnss*.so* $out/lib
        cp -d ${glibc}/lib/libresolv*.so* $out/lib
        cp -d ${glibc}/lib/crt?.o $out/lib

        cp -rL ${glibc}/include $out
        chmod -R u+w $out/include

        # Hopefully we won't need these.
        rm -rf $out/include/mtd $out/include/rdma $out/include/sound $out/include/video
        find $out/include -name .install -exec rm {} \;
        find $out/include -name ..install.cmd -exec rm {} \;
        mv $out/include $out/include-glibc

        # Copy coreutils, bash, etc.
        cp ${coreutilsMinimal}/bin/* $out/bin
        (cd $out/bin && rm vdir dir sha*sum pinky factor pathchk runcon shuf who whoami shred users)

        cp ${bash}/bin/bash $out/bin
        cp ${findutils}/bin/find $out/bin
        cp ${findutils}/bin/xargs $out/bin
        cp -d ${diffutils}/bin/* $out/bin
        cp -d ${gnused}/bin/* $out/bin
        cp -d ${gnugrep}/bin/grep $out/bin
        cp ${gawk}/bin/gawk $out/bin
        cp -d ${gawk}/bin/awk $out/bin
        cp ${gnutar}/bin/tar $out/bin
        cp ${gzip}/bin/gzip $out/bin
        cp ${bzip2}/bin/bzip2 $out/bin
        cp ${xz}/bin/xz $out/bin
        cp -d ${gnumake}/bin/* $out/bin
        cp -d ${patch}/bin/* $out/bin
        cp ${patchelf}/bin/* $out/bin
        cp ${curl-light}/bin/curl $out/bin

        # Add ca certificates for curl
        mkdir -p $out/etc/ssl/certs
        cp -d ${cacert}/ca-bundle.crt $out/etc/ssl/certs

        # Copy what we need of GCC.
        cp -d ${gcc.cc}/bin/gcc $out/bin
        cp -d ${gcc.cc}/bin/cpp $out/bin
        cp -d ${gcc.cc}/bin/g++ $out/bin
        cp -d ${gcc.cc}/lib*/libgcc_s.so* $out/lib
        cp -d ${gcc.cc}/lib*/libstdc++.so* $out/lib
        cp -rd ${gcc.cc}/lib/gcc $out/lib
        chmod -R u+w $out/lib
        rm -f $out/lib/gcc/*/*/include*/linux
        rm -f $out/lib/gcc/*/*/include*/sound
        rm -rf $out/lib/gcc/*/*/include*/root
        rm -f $out/lib/gcc/*/*/include-fixed/asm
        rm -rf $out/lib/gcc/*/*/plugin
        #rm -f $out/lib/gcc/*/*/*.a
        cp -rd ${gcc.cc}/libexec/* $out/libexec
        chmod -R u+w $out/libexec
        rm -rf $out/libexec/gcc/*/*/plugin
        mkdir $out/include
        cp -rd ${gcc.cc}/include/c++ $out/include
        chmod -R u+w $out/include
        rm -rf $out/include/c++/*/ext/pb_ds
        rm -rf $out/include/c++/*/ext/parallel

        # Copy binutils.
        for i in as ld ar ranlib nm strip readelf objdump; do
          cp ${binutils}/bin/$i $out/bin
        done

        # Copy all of the needed libraries for the binaries
        for BIN in $(find $out/bin -type f); do
          echo "Copying libs for bin $BIN"
          LDD="$(ldd $BIN)" || continue
          LIBS="$(echo "$LDD" | awk '{print $3}' | sed '/^$/d')"
          for LIB in $LIBS; do
            [ ! -f "$out/lib/$(basename $LIB)" ] && cp -pdv $LIB $out/lib
            while [ "$(readlink $LIB)" != "" ]; do
              LINK="$(readlink $LIB)"
              if [ "${LINK:0:1}" != "/" ]; then
                LINK="$(dirname $LIB)/$LINK"
              fi
              LIB="$LINK"
              [ ! -f "$out/lib/$(basename $LIB)" ] && cp -pdv $LIB $out/lib
            done
          done
        done

        chmod -R u+w $out

        # Strip executables even further.
        for i in $out/bin/* $out/libexec/gcc/*/*/*; do
            if test -x $i -a ! -L $i; then
                chmod +w $i
                strip -s $i || true
            fi
        done

        nuke-refs $out/bin/*
        nuke-refs $out/lib/*
        nuke-refs $out/libexec/gcc/*/*/*

        mkdir $out/.pack
        mv $out/* $out/.pack
        mv $out/.pack $out/pack

        mkdir $out/on-server
        tar cvfJ $out/on-server/bootstrap-tools.tar.xz -C $out/pack .
        cp ${busyboxBootstrap}/bin/busybox $out/on-server
        chmod u+w $out/on-server/busybox
        nuke-refs $out/on-server/busybox
      ''; # */

      # The result should not contain any references (store paths) so
      # that we can safely copy them out of the store and to other
      # locations in the store.
      allowedReferences = [];
    };

  test = ((import ./default.nix) {
    inherit system;
    
    customBootstrapFiles = {
      busybox = "${build}/on-server/busybox";
      bootstrapTools = "${build}/on-server/bootstrap-tools.tar.xz";
    };
  }).testBootstrapTools;
}
