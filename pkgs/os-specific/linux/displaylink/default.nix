{ stdenv, lib, fetchurl, unzip, utillinux, patchelfUnstable, bash,
  libusb1, evdi, systemd, makeWrapper, requireFile, buildFHSUserEnv, writeTextFile }:

let
  version = "4.1.9";
  libPath = lib.makeLibraryPath [ stdenv.cc.cc utillinux libusb1 evdi ];
  arch =
    if stdenv.system == "x86_64-linux" then "x64"
    else if stdenv.system == "i686-linux" then "x86"
    else throw "Unsupported architecture";
  fhsEnv = buildFHSUserEnv {
    name = "displaylink-fhs-env";
    targetPkgs = pkgs: with pkgs; [
      stdenv.cc.cc utillinux libusb1 evdi
    ];
  };
  bins = "${arch}-ubuntu-1604";

  displaylink = stdenv.mkDerivation {
    name = "displaylink-${version}";
    version = "${version}";

    src = requireFile rec {
      name = "displaylink.zip";
      sha256 = "d762145014df7fea8ca7af12206a077d73d8e7f2259c8dc2ce7e5fb1e69ef9a3";
      message = ''
        In order to install the DisplayLink drivers, you must first
        comply with DisplayLink's EULA and download the binaries and
        sources from here:

        http://www.displaylink.com/downloads/file?id=1087

        Once you have downloaded the file, please use the following
        commands and re-run the installation:

        mv \$PWD/"DisplayLink USB Graphics Software for Ubuntu ${version}.zip" \$PWD/${name}
        nix-prefetch-url file://\$PWD/${name}
      '';
    };

    nativeBuildInputs = [ unzip makeWrapper ];
    buildCommand = ''
      unzip $src
      chmod +x displaylink-driver-${version}.run
      ./displaylink-driver-${version}.run --target . --noexec

      sed -i "s,/opt/displaylink/udev.sh,$out/lib/udev/displaylink.sh,g" udev-installer.sh
      ( source udev-installer.sh
        mkdir -p $out/lib/udev/rules.d
        main systemd "$out/lib/udev/rules.d/99-displaylink.rules" "$out/lib/udev/displaylink.sh"
      )
      sed -i '2iPATH=${systemd}/bin:$PATH' $out/lib/udev/displaylink.sh

      install -Dt $out/lib/displaylink *.spkg
      install -Dm755 ${bins}/DisplayLinkManager $out/bin/DisplayLinkManager
      wrapProgram $out/bin/DisplayLinkManager \
        --run "cd $out/lib/displaylink"

      fixupPhase
    '';
    meta = with stdenv.lib; {
      description = "DisplayLink DL-5xxx, DL-41xx and DL-3x00 Driver for Linux";
      platforms = [ "x86_64-linux" "i686-linux" ];
      license = licenses.unfree;
      homepage = http://www.displaylink.com/;
    };
  };
in writeTextFile {
  name = "displaylink-wrapper";
  destination = "/bin/displaylink-wrapper";
  executable = true;
  text = ''
    #!${bash}/bin/bash
    exec ${fhsEnv}/bin/displaylink-fhs-env "${displaylink}/bin/DisplayLinkManager"
  '';
}
