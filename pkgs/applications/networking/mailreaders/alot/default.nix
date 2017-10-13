{ stdenv, lib
, pythonPackages, fetchFromGitHub, notmuch, file, gpgme
, withManpage ? true }:

with pythonPackages;

buildPythonApplication rec {
  version = "0.6";
  name = "alot-${version}";
  outputs = [ "out" "man" ];

  disabled = isPy3k;

  src = fetchFromGitHub {
    owner = "pazz";
    repo = "alot";
    rev = "${version}";
    sha256 = "1x6in9y823zi0k6xk62nwjybkc3pp5n2ml79x4v9jy6fz2klf2mi";
  };

  postPatch = ''
    substituteInPlace alot/defaults/alot.rc.spec \
      --replace "themes_dir = string(default=None)" \
                "themes_dir = string(default='$out/share/themes')"
  '';

  checkInputs =  [ mock pkgs.gnupg ];
  nativeBuildInputs = stdenv.lib.optionals withManpage [ sphinx ];

  propagatedBuildInputs = [
      notmuch
      urwid
      urwidtrees
      twisted
      python_magic
      configobj
      gpg
    ];

  # 3 tests fail, some unicode
  doCheck = false;
  postBuild = "make -C docs man";

  postInstall = ''
    mkdir -p $out/share/applications $out/man
    cp -r docs/build/man $out/man
    cp -r extra/themes $out/share

    sed "s,/usr/bin,$out/bin,g" extra/alot.desktop > $out/share/applications/alot.desktop
    wrapProgram $out/bin/alot \
      --prefix LD_LIBRARY_PATH : '${lib.makeLibraryPath [ notmuch file gpgme ]}'
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/pazz/alot;
    description = "Terminal MUA using notmuch mail";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ garbas profpatsch ];
  };
}

