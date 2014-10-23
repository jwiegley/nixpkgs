{ system, allPackages ? import ../../.., config }:

rec {

  shell =
    if system == "i686-freebsd" || system == "x86_64-freebsd" then "/usr/local/bin/bash"
    else "/bin/bash";

  path =
    (if system == "i686-solaris" then [ "/usr/gnu" ] else []) ++
    (if system == "i686-netbsd" then [ "/usr/pkg" ] else []) ++
    (if system == "x86_64-solaris" then [ "/opt/local/gnu" ] else []) ++
    ["/" "/usr" "/usr/local"];


  preHookBase = ''
    # Disable purity tests; it's allowed (even needed) to link to
    # libraries outside the Nix store (like the C library).
    export NIX_ENFORCE_PURITY=
  '';

  prehookFreeBSD = ''
    ${prehookBase}

    alias make=gmake
    alias tar=gtar
    alias sed=gsed
    alias sed-i='gsed -i""'
    export MAKE=gmake
    shopt -s expand_aliases
  '';

  preHookOpenBSD = ''
    ${preHookBase}

    alias make=gmake
    alias grep=ggrep
    alias mv=gmv
    alias ln=gln
    alias sed=gsed
    alias sed-i='gsed -i""'
    alias tar=gtar

    export MAKE=gmake
    shopt -s expand_aliases
  '';

  preHookNetBSD = ''
    ${preHookBase}

    alias make=gmake
    alias sed=gsed
    alias sed-i='gsed -i""'
    alias tar=gtar
    export MAKE=gmake
    shopt -s expand_aliases
  '';

  # Only used to build stdenvCygwin, check cygwin/default.nix.
  preHookCygwin = ''
    ${preHookBase}

    alias sed-i='sed -i""'
    shopt -s expand_aliases

    # prevent libtool from failing to find dynamic libraries
    export lt_cv_deplibs_check_method=pass_all
  '';

  extraBuildInputsCygwin = [
    ../cygwin/all-buildinputs-as-runtimedep.sh
    ../cygwin/wrap-exes-to-find-dlls.sh
  ] ++ (if system == "i686-cygwin" then [
    ../cygwin/rebase-i686.sh
  ] else if system == "x86_64-cygwin" then [
    ../cygwin/rebase-x86_64.sh
  ] else []);

  # A function that builds a "native" stdenv (one that uses tools in
  # /usr etc.).
  makeStdenv =
    { cc, fetchurl, extraPath ? [], overrides ? (pkgs: { }) }:

    import ../generic {
      preHook =
        if system == "i686-freebsd" then prehookFreeBSD else
        if system == "x86_64-freebsd" then prehookFreeBSD else
        if system == "i686-openbsd" then prehookOpenBSD else
        if system == "i686-netbsd" then prehookNetBSD else
        if system == "i686-cygwin" then preHookCygwin else
        if system == "x86_64-cygwin" then preHookCygwin else
        prehookBase;

      extraBuildInputs =
        if system == "i686-cygwin" then extraBuildInputsCygwin else
        if system == "x86_64-cygwin" then extraBuildInputsCygwin else
        [];

      initialPath = extraPath ++ path;

      fetchurlBoot = fetchurl;

      inherit system shell cc overrides config;
    };


  stdenvBoot0 = makeStdenv {
    cc = "/no-such-path";
    fetchurl = null;
  };


  cc = import ../../build-support/cc-wrapper {
    name = "cc-native";
    nativeTools = true;
    nativeLibc = true;
    nativePrefix = if system == "i686-solaris" then "/usr/gnu" else if system == "x86_64-solaris" then "/opt/local/gcc47" else "/usr";
    stdenv = stdenvBoot0;
  };


  fetchurl = import ../../build-support/fetchurl {
    stdenv = stdenvBoot0;
    # Curl should be in /usr/bin or so.
    curl = null;
  };


  # First build a stdenv based only on tools outside the store.
  stdenvBoot1 = makeStdenv {
    inherit cc fetchurl;
  } // {inherit fetchurl;};

  stdenvBoot1Pkgs = allPackages {
    inherit system;
    bootStdenv = stdenvBoot1;
  };


  # Using that, build a stdenv that adds the ‘xz’ command (which most
  # systems don't have, so we mustn't rely on the native environment
  # providing it).
  stdenvBoot2 = makeStdenv {
    inherit cc fetchurl;
    extraPath = [ stdenvBoot1Pkgs.xz ];
    overrides = pkgs: { inherit (stdenvBoot1Pkgs) xz; };
  };


  stdenv = stdenvBoot2;
}
