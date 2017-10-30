{ stdenv, fetchurl, substituteAll
, pkgconfig
, makeWrapper
, cups, zlib, libjpeg, libusb1, pythonPackages, sane-backends, dbus, usbutils
, net_snmp, openssl, polkit, nettools
, bash, coreutils, utillinux
, withQt5 ? true
, withPlugin ? false
}:

let

  name = "hplip-${version}";
  version = "3.17.9";

  src = fetchurl {
    url = "mirror://sourceforge/hplip/${name}.tar.gz";
    sha256 = "0y46jjq8jdfk9m4vjq55h8yggibvqbi9rl08vni7vbhxym1diamj";
  };

  plugin = fetchurl {
    url = "http://hplipopensource.com/hplip-web/plugin/${name}-plugin.run";
    sha256 = "10z8vzwcwmwni7s4j9xp0fa7l4lwrhl4kp450dga3fj0cck1gxwq";
  };

  hplipState = substituteAll {
    inherit version;
    src = ./hplip.state;
  };

  hplipPlatforms = {
    "i686-linux"   = "x86_32";
    "x86_64-linux" = "x86_64";
    "armv6l-linux" = "arm32";
    "armv7l-linux" = "arm32";
  };

  hplipArch = hplipPlatforms."${stdenv.system}"
    or (throw "HPLIP not supported on ${stdenv.system}");

  pluginArches = [ "x86_32" "x86_64" "arm32" ];

in

assert withPlugin -> builtins.elem hplipArch pluginArches
  || throw "HPLIP plugin not supported on ${stdenv.system}";

pythonPackages.buildPythonApplication {
  inherit name src;
  format = "other";

  buildInputs = [
    libjpeg
    cups
    libusb1
    sane-backends
    dbus
    net_snmp
    openssl
  ];

  nativeBuildInputs = [
    pkgconfig
  ];

  pythonPath = with pythonPackages; [
    dbus
    pillow
    pygobject2
    reportlab
    usbutils
  ] ++ stdenv.lib.optionals withQt5 [
    pyqt5
  ];

  makeWrapperArgs = [ ''--prefix PATH : "${nettools}/bin"'' ];

  prePatch = ''
    # HPLIP hardcodes absolute paths everywhere. Nuke from orbit.
    find . -type f -exec sed -i \
      -e s,/etc/hp,$out/etc/hp, \
      -e s,/etc/sane.d,$out/etc/sane.d, \
      -e s,/usr/include/libusb-1.0,${libusb1.dev}/include/libusb-1.0, \
      -e s,/usr/share/hal/fdi/preprobe/10osvendor,$out/share/hal/fdi/preprobe/10osvendor, \
      -e s,/usr/lib/systemd/system,$out/lib/systemd/system, \
      -e s,/var/lib/hp,$out/var/lib/hp, \
      {} +
  '';

  preConfigure = ''
    export configureFlags="$configureFlags
      --with-hpppddir=$out/share/cups/model/HP
      --with-cupsfilterdir=$out/lib/cups/filter
      --with-cupsbackenddir=$out/lib/cups/backend
      --with-icondir=$out/share/applications
      --with-systraydir=$out/xdg/autostart
      --with-mimedir=$out/etc/cups
      --enable-policykit
    "

    export makeFlags="
      halpredir=$out/share/hal/fdi/preprobe/10osvendor
      rulesdir=$out/etc/udev/rules.d
      policykit_dir=$out/share/polkit-1/actions
      policykit_dbus_etcdir=$out/etc/dbus-1/system.d
      policykit_dbus_sharedir=$out/share/dbus-1/system-services
      hplip_confdir=$out/etc/hp
      hplip_statedir=$out/var/lib/hp
    "
  '';

  enableParallelBuilding = true;

  postInstall = stdenv.lib.optionalString withPlugin ''
    sh ${plugin} --noexec --keep
    cd plugin_tmp

    cp plugin.spec $out/share/hplip/

    mkdir -p $out/share/hplip/data/firmware
    cp *.fw.gz $out/share/hplip/data/firmware

    mkdir -p $out/share/hplip/data/plugins
    cp license.txt $out/share/hplip/data/plugins

    mkdir -p $out/share/hplip/prnt/plugins
    for plugin in lj hbpl1; do
      cp $plugin-${hplipArch}.so $out/share/hplip/prnt/plugins
      ln -s $out/share/hplip/prnt/plugins/$plugin-${hplipArch}.so \
        $out/share/hplip/prnt/plugins/$plugin.so
    done

    mkdir -p $out/share/hplip/scan/plugins
    for plugin in bb_soap bb_marvell bb_soapht fax_marvell; do
      cp $plugin-${hplipArch}.so $out/share/hplip/scan/plugins
      ln -s $out/share/hplip/scan/plugins/$plugin-${hplipArch}.so \
        $out/share/hplip/scan/plugins/$plugin.so
    done

    mkdir -p $out/var/lib/hp
    cp ${hplipState} $out/var/lib/hp/hplip.state

    mkdir -p $out/etc/sane.d/dll.d
    mv $out/etc/sane.d/dll.conf $out/etc/sane.d/dll.d/hpaio.conf

    rm $out/etc/udev/rules.d/56-hpmud.rules
  '';

  # The installed executables are just symlinks into $out/share/hplip,
  # but wrapPythonPrograms ignores symlinks. We cannot replace the Python
  # modules in $out/share/hplip with wrapper scripts because they import
  # each other as libraries. Instead, we emulate wrapPythonPrograms by
  # 1. Calling patchPythonProgram on the original script in $out/share/hplip
  # 2. Making our own wrapper pointing directly to the original script.
  dontWrapPythonPrograms = true;
  preFixup = ''
    buildPythonPath "$out $pythonPath"

    for bin in $out/bin/*; do
      py=$(readlink -m $bin)
      rm $bin
      echo "patching \`$py'..."
      patchPythonScript "$py"
      echo "wrapping \`$bin'..."
      makeWrapper "$py" "$bin" \
          --prefix PATH ':' "$program_PATH" \
          --set PYTHONNOUSERSITE "true" \
          $makeWrapperArgs
    done
  '';

  postFixup = ''
    substituteInPlace $out/etc/hp/hplip.conf --replace /usr $out
  '' + stdenv.lib.optionalString (!withPlugin) ''
    # A udev rule to notify users that they need the binary plugin.
    # Needs a lot of patching but might save someone a bit of confusion:
    substituteInPlace $out/etc/udev/rules.d/56-hpmud.rules \
      --replace {,${bash}}/bin/sh \
      --replace {/usr,${coreutils}}/bin/nohup \
      --replace {,${utillinux}/bin/}logger \
      --replace {/usr,$out}/bin
  '';

  meta = with stdenv.lib; {
    description = "Print, scan and fax HP drivers for Linux";
    homepage = http://hplipopensource.com/;
    license = if withPlugin
      then licenses.unfree
      else with licenses; [ mit bsd2 gpl2Plus ];
    platforms = [ "i686-linux" "x86_64-linux" "armv6l-linux" "armv7l-linux" ];
    maintainers = with maintainers; [ jgeerds ttuegel ];
  };
}
