args @ { fetchurl, ... }:
rec {
  baseName = ''cl-cookie'';
  version = ''20150804-git'';

  description = ''HTTP cookie manager'';

  deps = [ args."quri" args."proc-parse" args."local-time" args."cl-ppcre" args."alexandria" ];

  src = fetchurl {
    url = ''http://beta.quicklisp.org/archive/cl-cookie/2015-08-04/cl-cookie-20150804-git.tgz'';
    sha256 = ''0llh5d2p7wi5amzpckng1bzmf2bdfdwkfapcdq0znqlzd5bvbby8'';
  };

  overrides = x: {
    postInstall = ''
      find "$out/lib/common-lisp/" -name '*.asd' | grep -iv '/cl-cookie[.]asd${"$"}' |
        while read f; do
          CL_SOURCE_REGISTRY= \
          NIX_LISP_PRELAUNCH_HOOK="nix_lisp_run_single_form '(asdf:load-system :$(basename "$f" .asd))'" \
            "$out"/bin/*-lisp-launcher.sh ||
          mv "$f"{,.sibling}; done || true
    '';
  };
}
/* (SYSTEM cl-cookie DESCRIPTION HTTP cookie manager SHA256 0llh5d2p7wi5amzpckng1bzmf2bdfdwkfapcdq0znqlzd5bvbby8 URL
    http://beta.quicklisp.org/archive/cl-cookie/2015-08-04/cl-cookie-20150804-git.tgz MD5 d2c08a71afd47b3ad42e1234ec1a3083 NAME cl-cookie TESTNAME NIL FILENAME
    cl-cookie DEPS ((NAME quri) (NAME proc-parse) (NAME local-time) (NAME cl-ppcre) (NAME alexandria)) DEPENDENCIES
    (quri proc-parse local-time cl-ppcre alexandria) VERSION 20150804-git SIBLINGS (cl-cookie-test)) */
