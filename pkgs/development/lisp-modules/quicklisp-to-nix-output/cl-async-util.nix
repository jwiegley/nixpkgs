args @ { fetchurl, ... }:
rec {
  baseName = ''cl-async-util'';
  version = ''cl-async-20160825-git'';

  description = ''Internal utilities for cl-async.'';

  deps = [ args."cffi" args."cl-async-base" args."cl-libuv" args."cl-ppcre" args."fast-io" args."vom" ];

  src = fetchurl {
    url = ''http://beta.quicklisp.org/archive/cl-async/2016-08-25/cl-async-20160825-git.tgz'';
    sha256 = ''104x6vw9zrmzz3sipmzn0ygil6ccyy8gpvvjxak2bfxbmxcl09pa'';
  };

  overrides = x: {
    postInstall = ''
        echo "$CL_SOURCE_REGISTRY"
        NIX_LISP_PRELAUNCH_HOOK='nix_lisp_run_single_form "(asdf:load-system :cl-async)"' "$out/bin/cl-async-util-lisp-launcher.sh" ""
    '';
  };
}
