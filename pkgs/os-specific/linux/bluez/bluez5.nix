{ stdenv, fetchurl, pkgconfig, dbus, glib, alsaLib,
  pythonPackages, readline, libsndfile, udev, libical,
  systemd, enableWiimote ? false }:

assert stdenv.isLinux;

stdenv.mkDerivation rec {
  name = "bluez-5.45";

  src = fetchurl {
    url = "mirror://kernel/linux/bluetooth/${name}.tar.xz";
    sha256 = "1sb4aflgyrl7apricjipa8wx95qm69yja0lmn2f19g560c3v1b2c";
  };

  pythonPath = with pythonPackages;
    [ dbus pygobject2 pygobject3 recursivePthLoader ];

  buildInputs =
    [ pkgconfig dbus glib alsaLib pythonPackages.python pythonPackages.wrapPython
      readline libsndfile udev libical
      # Disables GStreamer; not clear what it gains us other than a
      # zillion extra dependencies.
      # gstreamer gst-plugins-base
    ];

  outputs = [ "out" "dev" "test" ];

  patches = [ ./bluez-5.37-obexd_without_systemd-1.patch ];

  preConfigure = ''
      substituteInPlace tools/hid2hci.rules --replace /sbin/udevadm ${systemd}/bin/udevadm
      substituteInPlace tools/hid2hci.rules --replace "hid2hci " "$out/lib/udev/hid2hci "
    '';

  configureFlags = [
    "--localstatedir=/var"
    "--enable-library"
    "--enable-cups"
    "--with-dbusconfdir=$(out)/etc"
    "--with-dbussystembusdir=$(out)/share/dbus-1/system-services"
    "--with-dbussessionbusdir=$(out)/share/dbus-1/services"
    "--with-systemdsystemunitdir=$(out)/etc/systemd/system"
    "--with-systemduserunitdir=$(out)/etc/systemd/user"
    "--with-udevdir=$(out)/lib/udev"
    ] ++
    stdenv.lib.optional enableWiimote [ "--enable-wiimote" ];

  # Work around `make install' trying to create /var/lib/bluetooth.
  installFlags = "statedir=$(TMPDIR)/var/lib/bluetooth";

  makeFlags = "rulesdir=$(out)/lib/udev/rules.d";

  # FIXME: Move these into a separate package to prevent Bluez from
  # depending on Python etc.
  postInstall = ''
    # gatttool is no longer built by default. The following line is just
    # for historical reference and should be removed if no longer
    # deemed necessary
    #cp ./attrib/gatttool $out/bin/gatttool
    mkdir -p $test/test
    cp -a test $test
    pushd $test/test
    for a in \
            simple-agent \
            test-adapter \
            test-device \
            test-thermometer \
            list-devices \
            monitor-bluetooth \
            ; do
      ln -s ../test/$a $out/bin/bluez-$a
    done
    popd
    wrapPythonProgramsIn $test/test "$test/test $pythonPath"

    # for bluez4 compatibility for NixOS
    mkdir $out/sbin
    ln -s ../libexec/bluetooth/bluetoothd $out/sbin/bluetoothd
    ln -s ../libexec/bluetooth/obexd $out/sbin/obexd

    # Add extra configuration
    mkdir $out/etc/bluetooth
    ln -s /etc/bluetooth/main.conf $out/etc/bluetooth/main.conf
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = http://www.bluez.org/;
    repositories.git = https://git.kernel.org/pub/scm/bluetooth/bluez.git;
    description = "Bluetooth support for Linux";
    platforms = platforms.linux;
  };
}
