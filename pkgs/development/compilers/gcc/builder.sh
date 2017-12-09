source $stdenv/setup


export NIX_FIXINC_DUMMY=$NIX_BUILD_TOP/dummy
mkdir $NIX_FIXINC_DUMMY


if test "$staticCompiler" = "1"; then
    EXTRA_LDFLAGS="-static"
else
    EXTRA_LDFLAGS="-Wl,-rpath,$lib/lib"
fi


# GCC interprets empty paths as ".", which we don't want.
if test -z "$CPATH"; then unset CPATH; fi
if test -z "$LIBRARY_PATH"; then unset LIBRARY_PATH; fi
echo "\$CPATH is \`$CPATH'"
echo "\$LIBRARY_PATH is \`$LIBRARY_PATH'"

if test "$noSysDirs" = "1"; then

    if test -e $NIX_CC/nix-support/orig-libc; then

        # Figure out what extra flags to pass to the gcc compilers
        # being generated to make sure that they use our glibc.
        extraFlags="$(cat $NIX_CC/nix-support/libc-cflags || true)"
        extraLDFlags="$(cat $NIX_BINTOOLS/nix-support/libc-ldflags || true) $(cat $NIX_BINTOOLS/nix-support/libc-ldflags-before || true)"

        # Use *real* header files, otherwise a limits.h is generated
        # that does not include Glibc's limits.h (notably missing
        # SSIZE_MAX, which breaks the build).
        export NIX_FIXINC_DUMMY=$libc_dev/include

        # The path to the Glibc binaries such as `crti.o'.
        glibc_dir="$(cat $NIX_CC/nix-support/orig-libc || true)"
        glibc_libdir="$glibc_dir/lib"
        glibc_devdir="$(cat $NIX_CC/nix-support/orig-libc-dev || true)"

    else
        # Hack: support impure environments.
        extraFlags="-isystem /usr/include"
        extraLDFlags="-L/usr/lib64 -L/usr/lib"
        glibc_libdir="/usr/lib"
        export NIX_FIXINC_DUMMY=/usr/include
    fi

    extraFlags="-I$NIX_FIXINC_DUMMY $extraFlags"
    extraLDFlags="-L$glibc_libdir -rpath $glibc_libdir $extraLDFlags"

    # BOOT_CFLAGS defaults to `-g -O2'; since we override it below,
    # make sure to explictly add them so that files compiled with the
    # bootstrap compiler are optimized and (optionally) contain
    # debugging information (info "(gccinstall) Building").
    if test -n "$dontStrip"; then
        extraFlags="-O2 -g $extraFlags"
    else
        # Don't pass `-g' at all; this saves space while building.
        extraFlags="-O2 $extraFlags"
    fi

    EXTRA_FLAGS="$extraFlags"
    for i in $extraLDFlags; do
        EXTRA_LDFLAGS="$EXTRA_LDFLAGS -Wl,$i"
    done

    if test -n "$targetConfig"; then
        # Cross-compiling, we need gcc not to read ./specs in order to build
        # the g++ compiler (after the specs for the cross-gcc are created).
        # Having LIBRARY_PATH= makes gcc read the specs from ., and the build
        # breaks. Having this variable comes from the default.nix code to bring
        # gcj in.
        unset LIBRARY_PATH
        unset CPATH
    else
        if test -z "$crossConfig"; then
            EXTRA_TARGET_CFLAGS="$EXTRA_FLAGS"
            EXTRA_TARGET_CXXFLAGS="$EXTRA_FLAGS"
            EXTRA_TARGET_LDFLAGS="$EXTRA_LDFLAGS"
        else
            # This the case of cross-building the gcc.
            # We need special flags for the target, different than those of the build
            # Assertion:
            test -e $NIX_CC/nix-support/orig-libc

            # The path to the Glibc binaries such as `crti.o'.
            configureFlags="$configureFlags --with-native-system-header-dir=$glibc_devdir/include"

            # Use *real* header files, otherwise a limits.h is generated
            # that does not include Glibc's limits.h (notably missing
            # SSIZE_MAX, which breaks the build).
            NIX_FIXINC_DUMMY_CROSS="$glibc_devdir/include"

            extraFlags="-I$NIX_FIXINC_DUMMY_CROSS $extraFlags"
            extraLDFlags="-L$glibc_libdir -rpath $glibc_libdir $extraLDFlags"

            EXTRA_TARGET_CFLAGS="$extraFlags"
            for i in $extraLDFlags; do
                EXTRA_TARGET_LDFLAGS="$EXTRA_TARGET_LDFLAGS -Wl,$i"
            done
        fi
    fi

    # CFLAGS_FOR_TARGET are needed for the libstdc++ configure script to find
    # the startfiles.
    # FLAGS_FOR_TARGET are needed for the target libraries to receive the -Bxxx
    # for the startfiles.
    makeFlagsArray+=( \
        NATIVE_SYSTEM_HEADER_DIR="$NIX_FIXINC_DUMMY" \
        SYSTEM_HEADER_DIR="$NIX_FIXINC_DUMMY" \
        CFLAGS_FOR_BUILD="$EXTRA_FLAGS $EXTRA_LDFLAGS" \
        CXXFLAGS_FOR_BUILD="$EXTRA_FLAGS $EXTRA_LDFLAGS" \
        CFLAGS_FOR_TARGET="$EXTRA_TARGET_CFLAGS $EXTRA_TARGET_LDFLAGS" \
        CXXFLAGS_FOR_TARGET="$EXTRA_TARGET_CFLAGS $EXTRA_TARGET_LDFLAGS" \
        FLAGS_FOR_TARGET="$EXTRA_TARGET_CFLAGS $EXTRA_TARGET_LDFLAGS" \
        LDFLAGS_FOR_BUILD="$EXTRA_FLAGS $EXTRA_LDFLAGS" \
        LDFLAGS_FOR_TARGET="$EXTRA_TARGET_FLAGS $EXTRA_TARGET_LDFLAGS" \
        )

    if test -z "$targetConfig"; then
        makeFlagsArray+=( \
            BOOT_CFLAGS="$EXTRA_FLAGS $EXTRA_LDFLAGS" \
            BOOT_LDFLAGS="$EXTRA_TARGET_CFLAGS $EXTRA_TARGET_LDFLAGS" \
            )
    fi

    if test -n "$targetConfig" -a "$crossStageStatic" == 1; then
        # We don't want the gcc build to assume there will be a libc providing
        # limits.h in this stagae
        makeFlagsArray+=( \
            LIMITS_H_TEST=false \
            )
    else
        makeFlagsArray+=( \
            LIMITS_H_TEST=true \
            )
    fi
fi

if test -n "$targetConfig"; then
    # The host strip will destroy some important details of the objects
    dontStrip=1
fi

providedPreConfigure="$preConfigure";
preConfigure() {
    if test -n "$newlibSrc"; then
        tar xvf "$newlibSrc" -C ..
        ln -s ../newlib-*/newlib newlib
        # Patch to get armvt5el working:
        sed -i -e 's/ arm)/ arm*)/' newlib/configure.host
    fi

    # Bug - they packaged zlib
    if test -d "zlib"; then
        # This breaks the build without-headers, which should build only
        # the target libgcc as target libraries.
        # See 'configure:5370'
        rm -Rf zlib
    fi

    if test -f "$NIX_CC/nix-support/orig-libc"; then
        # Patch the configure script so it finds glibc headers.  It's
        # important for example in order not to get libssp built,
        # because its functionality is in glibc already.
        sed -i \
            -e "s,glibc_header_dir=/usr/include,glibc_header_dir=$libc_dev/include", \
            gcc/configure
    fi

    if test -n "$crossMingw" -a -n "$crossStageStatic"; then
        mkdir -p ../mingw
        # --with-build-sysroot expects that:
        cp -R $libcCross/include ../mingw
        configureFlags="$configureFlags --with-build-sysroot=`pwd`/.."
    fi

    # Eval the preConfigure script from nix expression.
    eval "$providedPreConfigure"

    # Perform the build in a different directory.
    mkdir ../build
    cd ../build
    configureScript=../$sourceRoot/configure
}


postConfigure() {
    # Don't store the configure flags in the resulting executables.
    sed -e '/TOPLEVEL_CONFIGURE_ARGUMENTS=/d' -i Makefile
}


preInstall() {
    # Make ‘lib64’ symlinks to ‘lib’.
    if [ -n "$is64bit" -a -z "$enableMultilib" ]; then
        mkdir -p "$out/lib"
        ln -s lib "$out/lib64"
        mkdir -p "$lib/lib"
        ln -s lib "$lib/lib64"
    fi
}


postInstall() {
    # Move runtime libraries to $lib.
    moveToOutput "lib/lib*.so*" "$lib"
    moveToOutput "lib/lib*.la"  "$lib"
    moveToOutput "lib/lib*.dylib" "$lib"
    moveToOutput "share/gcc-*/python" "$lib"

    for i in "$lib"/lib/*.{la,py}; do
        substituteInPlace "$i" --replace "$out" "$lib"
    done

    if [ -n "$enableMultilib" ]; then
        moveToOutput "lib64/lib*.so*" "$lib"
        moveToOutput "lib64/lib*.la"  "$lib"
        moveToOutput "lib64/lib*.dylib" "$lib"

        for i in "$lib"/lib64/*.{la,py}; do
            substituteInPlace "$i" --replace "$out" "$lib"
        done
    fi

    # Remove `fixincl' to prevent a retained dependency on the
    # previous gcc.
    rm -rf $out/libexec/gcc/*/*/install-tools
    rm -rf $out/lib/gcc/*/*/install-tools

    # More dependencies with the previous gcc or some libs (gccbug stores the build command line)
    rm -rf $out/bin/gccbug

    if type "patchelf"; then
        # Take out the bootstrap-tools from the rpath, as it's not needed at all having $out
        for i in $(find "$out"/libexec/gcc/*/*/* -type f -a \! -name '*.la'); do
            PREV_RPATH=`patchelf --print-rpath "$i"`
            NEW_RPATH=`echo "$PREV_RPATH" | sed 's,:[^:]*bootstrap-tools/lib,,g'`
            patchelf --set-rpath "$NEW_RPATH" "$i" && echo OK
        done

        # For some reason the libs retain RPATH to $out
        for i in "$lib"/lib/{libtsan,libasan,libubsan}.so.*.*.*; do
            PREV_RPATH=`patchelf --print-rpath "$i"`
            NEW_RPATH=`echo "$PREV_RPATH" | sed "s,:${out}[^:]*,,g"`
            patchelf --set-rpath "$NEW_RPATH" "$i" && echo OK
        done
    fi

    if type "install_name_tool"; then
        for i in "$lib"/lib/*.*.dylib; do
            install_name_tool -id "$i" "$i" || true
            for old_path in $(otool -L "$i" | grep "$out" | awk '{print $1}'); do
              new_path=`echo "$old_path" | sed "s,$out,$lib,"`
              install_name_tool -change "$old_path" "$new_path" "$i" || true
            done
        done
    fi

    # Get rid of some "fixed" header files
    rm -rfv $out/lib/gcc/*/*/include-fixed/{root,linux}

    # Replace hard links for i686-pc-linux-gnu-gcc etc. with symlinks.
    for i in $out/bin/*-gcc*; do
        if cmp -s $out/bin/gcc $i; then
            ln -sfn gcc $i
        fi
    done

    for i in $out/bin/c++ $out/bin/*-c++* $out/bin/*-g++*; do
        if cmp -s $out/bin/g++ $i; then
            ln -sfn g++ $i
        fi
    done

    # Disable RANDMMAP on grsec, which causes segfaults when using
    # precompiled headers.
    # See https://bugs.gentoo.org/show_bug.cgi?id=301299#c31
    paxmark r $out/libexec/gcc/*/*/{cc1,cc1plus}

    eval "$postInstallGhdl"

    # Two identical man pages are shipped (moving and compressing is done later)
    ln -sf gcc.1 "$out"/share/man/man1/g++.1
}

genericBuild
