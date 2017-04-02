args @ { fetchurl, ... }:
rec {
  baseName = ''cl-mysql'';
  version = ''20160628-git'';

  description = ''Common Lisp MySQL library bindings'';

  deps = [ args."cffi" ];

  src = fetchurl {
    url = ''http://beta.quicklisp.org/archive/cl-mysql/2016-06-28/cl-mysql-20160628-git.tgz'';
    sha256 = ''1zkijanw34nc91dn9jv30590ir6jw7bbcwjsqbvli69fh4b03319'';
  };

  overrides = x: {
    postInstall = ''
      find "$out/lib/common-lisp/" -name '*.asd' | grep -iv '/cl-mysql[.]asd${"$"}' |
        while read f; do
          CL_SOURCE_REGISTRY= \
          NIX_LISP_PRELAUNCH_HOOK="nix_lisp_run_single_form '(asdf:load-system :$(basename "$f" .asd))'" \
            "$out"/bin/*-lisp-launcher.sh ||
          mv "$f"{,.sibling}; done || true
    '';
  };
}
/* (SYSTEM cl-mysql DESCRIPTION Common Lisp MySQL library bindings SHA256 1zkijanw34nc91dn9jv30590ir6jw7bbcwjsqbvli69fh4b03319 URL
    http://beta.quicklisp.org/archive/cl-mysql/2016-06-28/cl-mysql-20160628-git.tgz MD5 349615d041c2f2177b678088f9c22409 NAME cl-mysql TESTNAME NIL FILENAME
    cl-mysql DEPS ((NAME cffi)) DEPENDENCIES (cffi) VERSION 20160628-git SIBLINGS (cl-mysql-test)) */
