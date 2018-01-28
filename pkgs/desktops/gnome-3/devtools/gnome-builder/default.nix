{stdenv
, autoconf
, clang
, clang-tools
, cmake
, ctags
, substituteAll
, defaultIconTheme
, devhelp
, fetchurl
, gettext
, gjs
, glib
, gnome_themes_standard
, gnumake
, gspell
, gtk3
, gtksourceview
, hicolor_icon_theme
, indent
, json_glib
, jsonrpc_glib
, libdazzle
, libgit2-glib
, libpeas
, libxml2
, llvmPackages
, meson
, ninja
, packagekit
, pcre
, pkgconfig
, python3
, python3Packages
, sysprof
, template_glib
, unzip
, vala
, vte
, webkitgtk
, which
, wrapGAppsHook
, ...}:

let
  major = "3.27";
  version = "${major}.2";
  pname = "gnome-builder";
in stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  nativeBuildInputs = [ gettext meson ninja pkgconfig python3 wrapGAppsHook ];
  buildInputs = [
    ctags defaultIconTheme devhelp gspell gtk3 gtksourceview json_glib
    jsonrpc_glib libdazzle libgit2-glib libpeas libxml2
    llvmPackages.clang llvmPackages.llvm pcre sysprof template_glib vala
    vte webkitgtk
  ];

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${major}/${pname}-${version}.tar.xz";
    sha256 = "1airzdpk56yzbp2y10sfkvhjk8xd7aj3z7z351i2132ivd0dni6c";
  };

  mesonFlags = "-D with_flatpak=false";

  patches = [
    ./patch_libide.patch
    (substituteAll {
      src = ./fix-paths.patch;
      glibDev = glib.dev;
      inherit autoconf clang clang-tools cmake gjs gnumake indent meson packagekit pkgconfig unzip which;
    })
  ];

  postPatch = ''
    patchShebangs build-aux/meson/post_install.py
    sed -e "s,^clang_include = ret.stdout().strip(),clang_include = '${clang.cc}/include/'," \
        -e "s,^clang_libdir = ret.stdout().strip().split(' '),clang_libdir = '${clang.cc}/lib/'," \
       -i src/plugins/clang/meson.build
  '';

  DESTDIR="/";

  postInstall = ''
    glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  pythonPath = with python3Packages; makePythonPath [ jedi pygobject3 sphinx ];
  preFixup = ''
    gappsWrapperArgs+=(--prefix LD_LIBRARY_PATH : "$out/lib/gnome-builder")
    gappsWrapperArgs+=(--prefix PYTHONPATH : "${pythonPath}")
  '';

  meta = {
    description = "An IDE for writing GNOME-based software.";
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ stdenv.lib.maintainers.andir ];
  };
}
