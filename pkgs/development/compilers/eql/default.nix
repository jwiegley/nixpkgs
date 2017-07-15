{ stdenv, fetchFromGitLab, qt4, ecl, xorgserver, xkbcomp, xkeyboard_config }:

stdenv.mkDerivation rec {
  version = src.rev;
  name = "eql-git-${version}";
  src = fetchFromGitLab {
    rev = "9097bf98446ee33c07bb155d800395775ce0d9b2";
    owner = "eql";
    repo = "eql";
    sha256 = "17h23qr7fyr9hvjgiq0yhacmjs43x06vh8978aq42ymcgipxdcww";
  };

  buildInputs = [ ecl qt4 xorgserver xkbcomp xkeyboard_config ];

  NIX_CFLAGS_COMPILE = [ "-fPIC" ];

  postPatch = ''
    sed -re 's@[(]in-home "gui/.command-history"[)]@(concatenate '"'"'string (ext:getenv "HOME") "/.eql-gui-command-history")@' -i gui/gui.lisp
  '';

  buildPhase = ''
    cd src
    ecl -shell make-eql-lib.lisp
    qmake eql_lib.pro
    make
    cd ..

    cd src
    qmake eql_exe.pro
    make
    cd ..
    cd src
  '';

  installPhase = ''
    cd ..
    mkdir -p $out/bin $out/lib/eql/ $out/include $out/include/gen $out/lib
    cp -r . $out/lib/eql/build-dir
    ln -s $out/lib/eql/build-dir/eql $out/bin
    ln -s $out/lib/eql/build-dir/src/*.h $out/include
    ln -s $out/lib/eql/build-dir/src/gen/*.h $out/include/gen
    ln -s $out/lib/eql/build-dir/libeql*.so* $out/lib
  '';

  meta = with stdenv.lib; {
    description = "Embedded Qt Lisp (ECL+Qt)";
    maintainers = with maintainers; [ raskin ];
    platforms = platforms.linux;
    license = licenses.mit;
  };

  passthru = {
    updateInfo = {
      downloadPage = "http://password-taxi.at/EQL";
      method = "fetchgit";
      rev = src.rev;
      url = src.url;
      hash = src.sha256;
    };
  };
}
