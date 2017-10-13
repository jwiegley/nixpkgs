{ stdenv, pkgs, pythonPackages
, fetchPypi
, withManpage ? true }:

with pythonPackages;

buildPythonPackage rec {
    version = "1.8.0";
    name = "gpg-${version}";
    pname = "gpg";

    disabled = isPy3k;

        src = fetchPypi {
          inherit pname version;
          sha256 = "1x74i6q713c0bckls7rdm8kgsmllf9qvy9x62jghszlhgjkyh9nd";
        };

    # src = pkgs.fetchFromGitHub {
    #   owner = "pazz";
    #   repo = "alot";
    #   inherit version;
    #   sha256 = "1x6in9y823zi0k6xk62nwjybkc3pp5n2ml79x4v9jy6fz2klf2mi";
    # };

    # postPatch = ''
    #   substituteInPlace alot/defaults/alot.rc.spec \
    #     --replace "themes_dir = string(default=None)" \
    #               "themes_dir = string(default='$out/share/themes')"
    # '';

    #  # uses that one https://github.com/mitchellrj/python-pgp
    # nativeBuildInputs = stdenv.lib.optionals withManpage [ sphinx python-gnupg ];
    propagatedBuildInputs = [
        pkgs.libgpgerror
        pkgs.gpgme
    #     urwid
    #     urwidtrees
    #     twisted
    #     python_magic
    #     configobj
    #     pygpgme
    #     mock
      ];

      # postBuild= stdenv.lib.optionalString withManpage "make -C docs man";
      # ''
      #   make man
      # '';
    # postInstall = ''
    #   mkdir -p $out/share
    #   cp -r extra/themes $out/share
    #   wrapProgram $out/bin/alot \
    #     --prefix LD_LIBRARY_PATH : '${pkgs.lib.makeLibraryPath [ pkgs.notmuch pkgs.file pkgs.gpgme ]}'
    # '';

    meta = {
      homepage = https://www.gnupg.org;
      description = "GPG bindings for python";
      license = stdenv.licenses.lgpl2;
      platforms = platforms.linux;
      maintainers = with maintainers; [ teto ];
    };
}


