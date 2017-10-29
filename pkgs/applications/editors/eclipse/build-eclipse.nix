{ stdenv, makeDesktopItem, freetype, fontconfig, libX11, libXrender
, zlib, jdk, glib, gtk2, libXtst, gsettings_desktop_schemas, webkitgtk24x-gtk2
, makeWrapper, ... }:

{ name, src ? builtins.getAttr stdenv.system sources, sources ? null, description }:

stdenv.mkDerivation rec {
  inherit name src;

  desktopItem = makeDesktopItem {
    name = "Eclipse";
    exec = "eclipse";
    icon = "eclipse";
    comment = "Integrated Development Environment";
    desktopName = "Eclipse IDE";
    genericName = "Integrated Development Environment";
    categories = "Application;Development;";
  };

  buildInputs = [
    fontconfig freetype glib gsettings_desktop_schemas gtk2 jdk libX11
    libXrender libXtst makeWrapper zlib
  ] ++ stdenv.lib.optional (webkitgtk24x-gtk2 != null) webkitgtk24x-gtk2;

  buildCommand = ''
    # Unpack tarball.
    mkdir -p $out
    tar xfvz $src -C $out

    # Patch binaries.
    interpreter=$(echo ${stdenv.glibc.out}/lib/ld-linux*.so.2)
    libCairo=$out/eclipse/libcairo-swt.so
    patchelf --set-interpreter $interpreter $out/eclipse/eclipse
    [ -f $libCairo ] && patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ freetype fontconfig libX11 libXrender zlib ]} $libCairo

    # Create wrapper script.  Pass -configuration to store
    # settings in ~/.eclipse/org.eclipse.platform_<version> rather
    # than ~/.eclipse/org.eclipse.platform_<version>_<number>.
    productId=$(sed 's/id=//; t; d' $out/eclipse/.eclipseproduct)
    productVersion=$(sed 's/version=//; t; d' $out/eclipse/.eclipseproduct)

    makeWrapper $out/eclipse/eclipse $out/bin/eclipse \
      --prefix PATH : ${jdk}/bin \
      --prefix LD_LIBRARY_PATH : ${stdenv.lib.makeLibraryPath ([ glib gtk2 libXtst ] ++ stdenv.lib.optional (webkitgtk24x-gtk2 != null) webkitgtk24x-gtk2)} \
      --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH" \
      --add-flags "-configuration \$HOME/.eclipse/''${productId}_$productVersion/configuration"

    # Create desktop item.
    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications
    mkdir -p $out/share/pixmaps
    ln -s $out/eclipse/icon.xpm $out/share/pixmaps/eclipse.xpm
  ''; # */

  meta = {
    homepage = https://www.eclipse.org/;
    inherit description;
  };

}
