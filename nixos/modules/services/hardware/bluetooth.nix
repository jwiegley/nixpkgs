{ config, lib, pkgs, ... }:

with lib;
let
    bluez-bluetooth = if config.services.xserver.desktopManager.kde4.enable then pkgs.bluez else pkgs.bluez5;

    configBluez = {
        description = "Bluetooth Service";
        serviceConfig = {
          Type = "dbus";
          BusName = "org.bluez";
          ExecStart = "${getBin bluez-bluetooth}/bin/bluetoothd -n";
        };
        wantedBy = [ "bluetooth.target" ];
    };

    configBluez5 =  {
        description = "Bluetooth Service";
        serviceConfig = {
          Type = "dbus";
          BusName = "org.bluez";
          ExecStart = "${getBin bluez-bluetooth}/bin/bluetoothd -n";
          NotifyAccess="main";
          CapabilityBoundingSet="CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
          LimitNPROC=1;
        };
        wantedBy = [ "bluetooth.target" ];
    };

    obexConfig = {
        description = "Bluetooth OBEX service";
        serviceConfig = {
          Type = "dbus";
          BusName = "org.bluez.obex";
          ExecStart = "${getBin bluez-bluetooth}/bin/obexd";
        };
    };

    bluezConfig = if config.services.xserver.desktopManager.kde4.enable then configBluez else configBluez5;
in

{

  ###### interface

  options = {

    hardware.bluetooth.enable = mkEnableOption "support for Bluetooth";

  };

  ###### implementation
  
  config = mkIf config.hardware.bluetooth.enable {

    environment.systemPackages = [ bluez-bluetooth pkgs.openobex pkgs.obexftp ];
    services.udev.packages = [ bluez-bluetooth ];
    services.dbus.packages = [ bluez-bluetooth ];
    systemd.services."dbus-org.bluez" = bluezConfig;
    systemd.services."dbus-org.bluez.obex" = obexConfig;

  };

}
