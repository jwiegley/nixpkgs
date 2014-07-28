{ fetchurl, stdenv, emacs, texinfo, which, texLive, texLiveCMSuper
, texLiveAggregationFun }:

stdenv.mkDerivation rec {
  name = "org-8.2.7b";

  src = fetchurl {
    url = "http://orgmode.org/${name}.tar.gz";
    sha256 = "07hq2q126d967nj7xq46q4mkca5r2rw61bn8d6nzkhksghp8b2v1";
  };

  buildInputs = [ emacs ];
  nativeBuildInputs = [ (texLiveAggregationFun { paths=[ texinfo texLive texLiveCMSuper ]; }) ];

  configurePhase =
    '' sed -i mk/default.mk \
           -e "s|^prefix\t=.*$|prefix=$out/share|g"
    '';

  postBuild =
    '' make doc
    '';

  installPhase =
    '' make install install-info

       mkdir -p "$out/share/doc/${name}"
       cp -v doc/org*.{html,pdf,txt} "$out/share/doc/${name}"

       mkdir -p "$out/share/org"
       cp -R contrib "$out/share/org/contrib"
    '';

  meta = {
    description = "Org-Mode, an Emacs mode for notes, project planning, and authoring";

    longDescription =
      '' Org-mode is for keeping notes, maintaining ToDo lists, doing project
         planning, and authoring with a fast and effective plain-text system.

         This package contains a version of Org-mode typically more recent
         than that found in GNU Emacs.
      '';

    license = stdenv.lib.licenses.gpl3Plus;

    maintainers = with stdenv.lib.maintainers; [ chaoflow pSub ];
    platforms = stdenv.lib.platforms.unix;
  };
}
