# The Nixpkgs CC is not directly usable, since it doesn't know where
# the C library and standard header files are. Therefore the compiler
# produced by that package cannot be installed directly in a user
# environment and used from the command line. So we use a wrapper
# script that sets up the right environment variables so that the
# compiler and the linker just "work".

{ name ? "", stdenvNoCC, nativeTools, noLibc ? false, nativeLibc, nativePrefix ? ""
, bintools ? null, libc ? null
, coreutils ? null, shell ? stdenvNoCC.shell, gnugrep ? null
, extraPackages ? [], extraBuildCommands ? ""
, buildPackages ? {}
, useMacosReexportHack ? false
}:

with stdenvNoCC.lib;

assert nativeTools -> nativePrefix != "";
assert !nativeTools ->
  bintools != null && coreutils != null && gnugrep != null;
assert !(nativeLibc && noLibc);
assert (noLibc || nativeLibc) == (libc == null);

let
  stdenv = stdenvNoCC;
  inherit (stdenv) hostPlatform targetPlatform;

  # Prefix for binaries. Customarily ends with a dash separator.
  #
  # TODO(@Ericson2314) Make unconditional, or optional but always true by
  # default.
  targetPrefix = stdenv.lib.optionalString (targetPlatform != hostPlatform)
                                        (targetPlatform.config + "-");

  bintoolsVersion = (builtins.parseDrvName bintools.name).version;
  bintoolsName = (builtins.parseDrvName bintools.name).name;

  libc_bin = if libc == null then null else getBin libc;
  libc_dev = if libc == null then null else getDev libc;
  libc_lib = if libc == null then null else getLib libc;
  bintools_bin = if nativeTools then "" else getBin bintools;
  # The wrapper scripts use 'cat' and 'grep', so we may need coreutils.
  coreutils_bin = if nativeTools then "" else getBin coreutils;

  dashlessTarget = stdenv.lib.replaceStrings ["-"] ["_"] targetPlatform.config;

  # See description in cc-wrapper.
  infixSalt = dashlessTarget;

  # The dynamic linker has different names on different platforms. This is a
  # shell glob that ought to match it.
  dynamicLinker =
    /**/ if libc == null then null
    else if targetPlatform.system == "i686-linux"     then "${libc_lib}/lib/ld-linux.so.2"
    else if targetPlatform.system == "x86_64-linux"   then "${libc_lib}/lib/ld-linux-x86-64.so.2"
    # ARM with a wildcard, which can be "" or "-armhf".
    else if (with targetPlatform; isArm && isLinux)   then "${libc_lib}/lib/ld-linux*.so.3"
    else if targetPlatform.system == "aarch64-linux"  then "${libc_lib}/lib/ld-linux-aarch64.so.1"
    else if targetPlatform.system == "powerpc-linux"  then "${libc_lib}/lib/ld.so.1"
    else if targetPlatform.system == "mips64el-linux" then "${libc_lib}/lib/ld.so.1"
    else if targetPlatform.isDarwin                   then "/usr/lib/dyld"
    else if stdenv.lib.hasSuffix "pc-gnu" targetPlatform.config then "ld.so.1"
    else null;

  expand-response-params =
    if buildPackages.stdenv.cc or null != null && buildPackages.stdenv.cc != "/dev/null"
    then import ../expand-response-params { inherit (buildPackages) stdenv; }
    else "";

in

stdenv.mkDerivation {
  name = targetPrefix
    + (if name != "" then name else "${bintoolsName}-wrapper")
    + (stdenv.lib.optionalString (bintools != null && bintoolsVersion != "") "-${bintoolsVersion}");

  preferLocalBuild = true;

  inherit libc_dev libc_lib coreutils_bin;
  shell = getBin shell + shell.shellPath or "";
  gnugrep_bin = if nativeTools then "" else gnugrep;

  inherit targetPrefix infixSalt;

  outputs = [ "out" "info" "man" ];

  passthru = {
    inherit bintools libc nativeTools nativeLibc nativePrefix;

    emacsBufferSetup = pkgs: ''
      ; We should handle propagation here too
      (mapc
        (lambda (arg)
          (when (file-directory-p (concat arg "/lib"))
            (setenv "NIX_${infixSalt}_LDFLAGS" (concat (getenv "NIX_${infixSalt}_LDFLAGS") " -L" arg "/lib")))
          (when (file-directory-p (concat arg "/lib64"))
            (setenv "NIX_${infixSalt}_LDFLAGS" (concat (getenv "NIX_${infixSalt}_LDFLAGS") " -L" arg "/lib64"))))
        '(${concatStringsSep " " (map (pkg: "\"${pkg}\"") pkgs)}))
    '';
  };

  dontBuild = true;
  dontConfigure = true;

  unpackPhase = ''
    src=$PWD
  '';

  installPhase =
    ''
      set -u

      mkdir -p $out/bin {$out,$info,$man}/nix-support

      wrap() {
        local dst="$1"
        local wrapper="$2"
        export prog="$3"
        set +u
        substituteAll "$wrapper" "$out/bin/$dst"
        set -u
        chmod +x "$out/bin/$dst"
      }
    ''

    + (if nativeTools then ''
      echo ${nativePrefix} > $out/nix-support/orig-bintools

      ldPath="${nativePrefix}/bin"
    '' else ''
      echo ${bintools_bin} > $out/nix-support/orig-bintools

      ldPath="${bintools_bin}/bin"
    ''

    + optionalString (targetPlatform.isSunOS && nativePrefix != "") ''
      # Solaris needs an additional ld wrapper.
      ldPath="${nativePrefix}/bin"
      exec="$ldPath/${targetPrefix}ld"
      wrap ld-solaris ${./ld-solaris-wrapper.sh}
    '')

    + ''
      # Create a symlink to as (the assembler).
      if [ -e $ldPath/${targetPrefix}as ]; then
        ln -s $ldPath/${targetPrefix}as $out/bin/${targetPrefix}as
      fi

    '' + (if !useMacosReexportHack then ''
      wrap ${targetPrefix}ld ${./ld-wrapper.sh} ''${ld:-$ldPath/${targetPrefix}ld}
    '' else ''
      ldInner="${targetPrefix}ld-reexport-delegate"
      wrap "$ldInner" ${./macos-sierra-reexport-hack.bash} ''${ld:-$ldPath/${targetPrefix}ld}
      wrap "${targetPrefix}ld" ${./ld-wrapper.sh} "$out/bin/$ldInner"
      unset ldInner
    '') + ''

      for variant in ld.gold ld.bfd ld.lld; do
        local underlying=$ldPath/${targetPrefix}$variant
        [[ -e "$underlying" ]] || continue
        wrap ${targetPrefix}$variant ${./ld-wrapper.sh} $underlying
      done

      set +u
    '';

  propagatedBuildInputs = [ bintools_bin libc_bin coreutils_bin ] ++ extraPackages;

  setupHook = ./setup-hook.sh;

  postFixup =
    ''
      set -u
    ''

    + optionalString (libc != null) (''
      ##
      ## General libc support
      ##

      echo "-L${libc_lib}/lib" > $out/nix-support/libc-ldflags

      echo "${libc_lib}" > $out/nix-support/orig-libc
      echo "${libc_dev}" > $out/nix-support/orig-libc-dev

      ##
      ## Dynamic linker support
      ##

      if [[ -z ''${dynamicLinker+x} ]]; then
        echo "Don't know the name of the dynamic linker for platform '${targetPlatform.config}', so guessing instead." >&2
        local dynamicLinker="${libc_lib}/lib/ld*.so.?"
      fi

      # Expand globs to fill array of options
      dynamicLinker=($dynamicLinker)

      case ''${#dynamicLinker[@]} in
        0) echo "No dynamic linker found for platform '${targetPlatform.config}'." >&2;;
        1) echo "Using dynamic linker: '$dynamicLinker'" >&2;;
        *) echo "Multiple dynamic linkers found for platform '${targetPlatform.config}'." >&2;;
      esac

      if [ -n "''${dynamicLinker:-}" ]; then
        echo $dynamicLinker > $out/nix-support/dynamic-linker

    '' + (if targetPlatform.isDarwin then ''
        printf "export LD_DYLD_PATH=%q\n" "$dynamicLinker" >> $out/nix-support/setup-hook
    '' else ''
        if [ -e ${libc_lib}/lib/32/ld-linux.so.2 ]; then
          echo ${libc_lib}/lib/32/ld-linux.so.2 > $out/nix-support/dynamic-linker-m32
        fi

        local ldflagsBefore=(-dynamic-linker "$dynamicLinker")
    '') + ''
      fi

      # The dynamic linker is passed in `ldflagsBefore' to allow
      # explicit overrides of the dynamic linker by callers to ld
      # (the *last* value counts, so ours should come first).
      printWords "''${ldflagsBefore[@]}" > $out/nix-support/libc-ldflags-before
    '')

    + optionalString (!nativeTools) ''

      ##
      ## User env support
      ##

      # Propagate the underling unwrapped bintools so that if you
      # install the wrapper, you get tools like objdump, the manpages,
      # etc. as well (same for any binaries of libc).
      printWords ${bintools_bin} ${if libc == null then "" else libc_bin} > $out/nix-support/propagated-user-env-packages

      ##
      ## Man page and info support
      ##

      printWords ${bintools.info or ""} \
        >> $info/nix-support/propagated-build-inputs
      printWords ${bintools.man or ""} \
        >> $man/nix-support/propagated-build-inputs
    ''

    + ''

      ##
      ## Hardening support
      ##

      # some linkers on some platforms don't support specific -z flags
      export hardening_unsupported_flags=""
      if [[ "$($ldPath/${targetPrefix}ld -z now 2>&1 || true)" =~ un(recognized|known)\ option ]]; then
        hardening_unsupported_flags+=" bindnow"
      fi
      if [[ "$($ldPath/${targetPrefix}ld -z relro 2>&1 || true)" =~ un(recognized|known)\ option ]]; then
        hardening_unsupported_flags+=" relro"
      fi
    ''

    + optionalString hostPlatform.isCygwin ''
      hardening_unsupported_flags+=" pic"
    ''

    + ''
      set +u
      substituteAll ${./add-flags.sh} $out/nix-support/add-flags.sh
      substituteAll ${./add-hardening.sh} $out/nix-support/add-hardening.sh
      substituteAll ${../cc-wrapper/utils.sh} $out/nix-support/utils.sh

      ##
      ## Extra custom steps
      ##

    ''
    + extraBuildCommands;

  inherit dynamicLinker expand-response-params;

  # for substitution in utils.sh
  expandResponseParams = "${expand-response-params}/bin/expand-response-params";

  meta =
    let bintools_ = if bintools != null then bintools else {}; in
    (if bintools_ ? meta then removeAttrs bintools.meta ["priority"] else {}) //
    { description =
        stdenv.lib.attrByPath ["meta" "description"] "System binary utilities" bintools_
        + " (wrapper script)";
  } // optionalAttrs useMacosReexportHack {
    platforms = stdenv.lib.platforms.darwin;
  };
}
