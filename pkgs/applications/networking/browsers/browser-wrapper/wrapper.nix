{ stdenv, lib, browser, makeDesktopItem, makeWrapper, plugins, libs, gtk_modules
, browserName, desktopName, nameSuffix, icon, binPath, extraFlags
}:

let p = builtins.parseDrvName browser.name; in

stdenv.mkDerivation {
  name = "${p.name}-with-plugins-${p.version}";

  desktopItem = makeDesktopItem {
    name = browserName;
    exec = browserName + " %U";
    icon = icon;
    comment = "";
    desktopName = desktopName;
    genericName = "Web Browser";
    categories = "Application;Network;WebBrowser;";
  };

  buildInputs = [makeWrapper];

  buildCommand = ''
    if [ ! -x "${binPath}" ]
    then
        echo "cannot find executable file \`${binPath}'"
        exit 1
    fi

    makeWrapper "${binPath}" \
        "$out/bin/${browserName}${nameSuffix}" \
        --suffix-each MOZ_PLUGIN_PATH ':' "$plugins" \
        --suffix-each LD_LIBRARY_PATH ':' "$libs" \
        --suffix-each GTK_PATH ':' "$gtk_modules" \
        --suffix-each LD_PRELOAD ':' "$(cat $(filterExisting $(addSuffix /extra-ld-preload $plugins)))" \
        --prefix-contents PATH ':' "$(filterExisting $(addSuffix /extra-bin-path $plugins))" \
        --add-flags "${extraFlags}"

    mkdir -p $out/share/applications
    cp $desktopItem/share/applications/* $out/share/applications

    # For manpages, in case the program supplies them
    mkdir -p $out/nix-support
    echo ${browser} > $out/nix-support/propagated-user-env-packages
  '';

  preferLocalBuild = true;

  # Let each plugin tell us (through its `mozillaPlugin') attribute
  # where to find the plugin in its tree.
  plugins = map (x: x + x.mozillaPlugin) plugins;
  libs = map (x: x + "/lib") libs ++ map (x: x + "/lib64") libs;
  gtk_modules = map (x: x + x.gtkModule) gtk_modules;

  meta = {
    description =
      browser.meta.description
      + " (with plugins: "
      + lib.concatStrings (lib.intersperse ", " (map (x: x.name) plugins))
      + ")";
  };
}
