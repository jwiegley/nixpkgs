args @ { fetchurl, ... }:
rec {
  baseName = ''trivial-utf-8'';
  version = ''20111001-darcs'';

  description = '''';

  deps = [ ];

  src = fetchurl {
    url = ''http://beta.quicklisp.org/archive/trivial-utf-8/2011-10-01/trivial-utf-8-20111001-darcs.tgz'';
    sha256 = ''1lmg185s6w3rzsz3xa41k5w9xw32bi288ifhrxincy8iv92w65wb'';
  };

  overrides = x: {
    postInstall = ''
      find "$out/lib/common-lisp/" -name '*.asd' | grep -iv '/trivial-utf-8[.]asd${"$"}' |
        while read f; do
          CL_SOURCE_REGISTRY= \
          NIX_LISP_PRELAUNCH_HOOK="nix_lisp_run_single_form '(asdf:load-system :$(basename "$f" .asd))'" \
            "$out"/bin/*-lisp-launcher.sh ||
          mv "$f"{,.sibling}; done || true
    '';
  };
}
/* (SYSTEM trivial-utf-8 DESCRIPTION NIL SHA256 1lmg185s6w3rzsz3xa41k5w9xw32bi288ifhrxincy8iv92w65wb URL
    http://beta.quicklisp.org/archive/trivial-utf-8/2011-10-01/trivial-utf-8-20111001-darcs.tgz MD5 0206c4ba7a6c0b9b23762f244aca6614 NAME trivial-utf-8
    TESTNAME NIL FILENAME trivial-utf-8 DEPS NIL DEPENDENCIES NIL VERSION 20111001-darcs SIBLINGS NIL) */
