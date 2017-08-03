{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  version = "3.4.0";
  dependencies = [
    boehmgc
    xorg.libXext
    xorg.libXtst
    xorg.libXi
    xorg.libXt
    xorg.libXpm
    xorg.libXp
    xorg.libXmu
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXau
    xorg.libXcursor
    xorg.libXdmcp
    xorg.libXfixes
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXrender
    ncurses
    gtk2-x11
    atk
    cairo
    expat
    fontconfig
    fontconfig-ultimate
    freetype
    glib
    gnome2.pango
    libpng
    zlib
    nss
    nspr
    curl
    alsaLib
    haxe
  ];
  libPath = stdenv.lib.makeLibraryPath dependencies;
  embeddedLibPath = ''
    $out/share/plaf/haxe/lib/hxcpp/hxcpp/bin/Android:$out/share/plaf/haxe/lib/hxcpp/hxcpp/project/libs/nekoapi/bin/Linux:$out/share/plaf/haxe/lib/hxcpp/hxcpp/project/libs/nekoapi/bin/Linux64:$out/share/plaf/haxe/lib/hxcpp/hxcpp/project/libs/nekoapi/bin/RPi:$out/share/plaf/haxe/lib/lime/lime/ndll/Android:$out/share/plaf/haxe/lib/lime/lime/templates/java/ndll/Linux:$out/share/plaf/haxe/lib/lime/lime/templates/java/ndll/Linux64:$out/share/plaf/haxe/lib/lime/lime/templates/neko/ndll/linux:$out/share/plaf/haxe/lib/lime/lime/templates/neko/ndll/linux64:$out/share/plaf/haxe/lib/lime/lime/templates/neko/ndll/rpi:$out/share/plaf/neko-linux:$out/share/runtimes/jre-linux/lib/amd64:$out/share/runtimes/jre-linux/lib/amd64/jli:$out/share/runtimes/jre-linux/lib/amd64/server
  '';
in
  stdenv.mkDerivation {

  name = "stencyl-${version}";

  src = fetchurl {
    url = "http://www.stencyl.com/download/get/lin64/";
    name = "Stencyl-64-full.tar.gz";
    sha256 = "0adgsisk95hp0kiwzj49nb6w2d8g6hi0snkqbp1l7x5mhgf00zf2";
  };

  buildInputs = [
    file
    makeWrapper
  ];

  unpackCmd = ''
    tar -xf $curSrc --one-top-level=stencyl
  '';

  buildPhase = ''

    # patch executables
    find -executable -type f -exec file {} \; | \
    grep 'ELF.*executable.*interpreter' | \
    awk '{print $1}' | \
    tr -d ':' | \
    while read elf_executable; do
      echo "Patching ELF interpreter for executable: $elf_executable"
      patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${libPath}:${embeddedLibPath}" \
        "$elf_executable"  
    done

    # patch shared object files
    find -iname '*\.so*' | \
    while read so; do
      echo "Patching shared object file: $so"
      patchelf --set-rpath "${libPath}:${embeddedLibPath}" "$so"
    done

  '';

  installPhase = let
    binPath = stdenv.lib.makeBinPath [ psmisc ];
  in ''
    mkdir -p $out/bin $out/share
    mv * $out/share
    makeWrapper "$out/share/Stencyl" "$out/bin/stencyl" \
      --prefix LD_LIBRARY_PATH : "${libPath}" \
      --prefix PATH : "${binPath}"
  '';

}
