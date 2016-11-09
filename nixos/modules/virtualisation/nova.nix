{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.virtualisation.nova;
  rootwrapConf =  pkgs.writeText "nova-rootwrap.conf" ''
    [DEFAULT]
    filters_path=${cfg.package}/etc/nova/rootwrap.d

    # List of directories to search executables in, in case filters do not
    # explicitely specify a full path (separated by ',')
    # If not specified, defaults to system PATH environment variable.
    # These directories MUST all be only writeable by root !
    exec_dirs=${pkgs.iptables}/bin,${pkgs.iputils}/bin

    # Enable logging to syslog
    # Default value is False
    use_syslog=False

    # Which syslog facility to use.
    # Valid values include auth, authpriv, syslog, local0, local1...
    # Default value is 'syslog'
    syslog_log_facility=syslog

    # Which messages to log.
    # INFO means log all usage
    # ERROR means only log unsuccessful attempts
    syslog_log_level=ERROR
  '';
  novaConf = pkgs.writeText "nova.conf" ''
    [DEFAULT]
    dhcpbridge_flagfile = ${cfg.package}/etc/nova/nova.conf
    dhcpbridge = ${cfg.package}/bin/nova-dhcpbridge
    state_path = /var/lib/nova
    force_dhcp_release = True
    iscsi_helper = tgtadm
    libvirt_use_virtio_for_bridges = True
    connection_type = libvirt
    rootwrap_config = ${rootwrapConf}
    ec2_private_dns_show_ip = True
    api_paste_config = ${cfg.package}/etc/nova/api-paste.ini
    policy_file=${cfg.package}/etc/nova/policy.json
    volumes_path = /var/lib/nova/volumes
    enabled_apis = osapi_compute,metadata
    network_api_class = nova.network.neutronv2.api.API
    firewall_driver = nova.virt.firewall.NoopFirewallDriver
    security_group_api = neutron
    linuxnet_interface_driver = nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
    auth_strategy = keystone
    force_config_drive = always
    fixed_ip_disassociate_timeout = 30
    enable_instance_password = False
    service_neutron_metadata_proxy = True
    neutron_metadata_proxy_shared_secret = openstack
    mkisofs_cmd = ${pkgs.cdrkit}/bin/genisoimage

    # nova-compute
    compute_driver = libvirt.LibvirtDriver

    [database]
    connection = mysql://nova:${cfg.dbPassword}@${cfg.dbHost}/nova

    [glance]
    host = localhost

    [keystone_authtoken]
    auth_uri = http://localhost:5000
    auth_url = http://localhost:35357
    auth_plugin = password
    project_name = service
    project_domain_id = default
    user_domain_id = default
    username = ${cfg.serviceUsername}
    password = ${cfg.serviceUsername}

    [neutron]
    url=http://localhost:9696
    admin_username = ${cfg.neutronServiceUsername}
    admin_password = ${cfg.neutronServicePassword}
    admin_tenant_name = service
    admin_auth_url = http://localhost:5000/v2.0
    auth_strategy = keystone
    region_name = RegionOne
    service_metadata_proxy = True
    metadata_proxy_shared_secret = METADATA_SECRET

    [oslo_concurrency]
    lock_path = /var/lock/nova

    [libvirt]
    virt_type = qemu

    [oslo_messaging_rabbit]
    rabbit_host = localhost
    ${cfg.extraConfig}
  '';
  loggingConf = pkgs.writeText "logging-nova-api.conf"  ''
    [loggers]
    keys = nova, root

    [handlers]
    keys = stderr

    [formatters]
    keys = default

    [handler_stderr]
    class = StreamHandler
    args = (sys.stderr,)
    level = NOTSET
    formatter = default

    [logger_root]
    level = WARNING
    handlers = stderr
    formatter = default

    [logger_nova]
    level = DEBUG
    handlers = stderr
    qualname = oslo_concurrency.processutils
    formatter = default

    [formatter_default]
    format = %(message)s
  '';
in {
  options = {

    virtualisation.nova = {
      package = mkOption {
        type = types.package;
        example = literalExample "pkgs.nova";
        description = ''
          Nova package to use.
        '';
      };

      enableSingleNode = mkOption {
        default = false;
        type = types.bool;
        description = ''
            This option enables Nova, also known as OpenStack Compute,
            a cloud computing system, as a single-machine
            installation.  That is, all of Nova's components are
            enabled on this machine. This is useful for evaluating and
            experimenting with Nova. However, for a real cloud
            computing environment, you'll want to enable some of
            Nova's services on other machines.
          '';
      };

      neutronServiceUsername = mkOption {
        default = "neutron";
        description = "The username of the neutron service tenant";
        example = "neutron";
      };
      neutronServicePassword = mkOption {
        default = "neutron";
        description = "The password of the neutron service user";
        example = "neutron";
      };

      serviceUsername = mkOption {
        default = "nova";
        description = "The username used for the nova service tenant";
        example = "nova";
      };
      servicePassword = mkOption {
        default = "nova";
        description = "The password of the nova service user";
        example = "nova";
      };

      dbHost = mkOption {
        default = "localhost";
        description = "The location of the database server";
        example = "localhost";
      };

      dbPassword = mkOption {
        default = "nova";
        description = "The mysql password";
        example = "nova";
      };
    
      endpointPublic = mkOption {
        type = types.str;
        default = "localhost";
        description = ''
        '';
      };

      extraConfig = mkOption {
        default = "";
        type = types.lines;
        description = ''
            Additional text appended to <filename>nova.conf</filename>,
            the main Nova configurlmation file.
          '';
      };
          
      keystoneAdminUsername = mkOption {
        type = types.str;
        default = "admin";
        description = ''
        '';
      };

      keystoneAdminPassword = mkOption {
        type = types.str;
        default = "admin";
        description = ''
        '';
      };

      keystoneAdminTenant = mkOption {
        type = types.str;
        default = "admin";
        description = ''
        '';
      };

    };
  };

  config = mkIf cfg.enableSingleNode {
    # Note: when changing the default, make it conditional on
    # ‘system.stateVersion’ to maintain compatibility with existing
    # systems!
    virtualisation.nova.package = mkDefault pkgs.nova;

    # See https://wiki.openstack.org/wiki/Rootwrap
    security.sudo.enable = true;
    security.sudo.extraConfig = ''
      nova ALL = (root) NOPASSWD: ${cfg.package}/bin/nova-rootwrap ${rootwrapConf} *
    '';

    users.extraUsers = [{
      name = "nova";
      group = "nova";
    }];
    users.extraGroups = [{
      name = "nova";
    }];

    # Nova requires libvirtd and RabbitMQ.
    services.rabbitmq.enable = true;

    # `qemu-nbd' required the `nbd' kernel module.
    boot.kernelModules = [ "nbd" ];

    systemd.services.nova-api = {
      description = "OpenStack Nova API Daemon";
      after = [ "rabbitmq.service" "mysql.service" "network.target" ];
      wantedBy = [ "multi-user.target" ];
      preStart = ''
        mkdir -m 755 -p /var/lib/nova/networks
        mkdir -m 775 -p /var/lib/nova/{instances,keys}
        mkdir -m 775 -p /var/lock/nova

        chown -R nova:nova /var/lock/nova /var/lib/nova/

        ${pkgs.mysql}/bin/mysql -u root -N -e "CREATE DATABASE nova;" || true
        ${pkgs.mysql}/bin/mysql -u root -N -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'${cfg.dbHost}' IDENTIFIED BY '${cfg.dbPassword}';"
        ${pkgs.mysql}/bin/mysql -u root -N -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' IDENTIFIED BY '${cfg.dbPassword}';"

        # Initialise the database
        ${cfg.package}/bin/nova-manage --config-file=${novaConf} db sync
      '';
      postStart = ''
	export OS_AUTH_URL=http://localhost:5000/v2.0
	export OS_USERNAME=${cfg.keystoneAdminUsername}
	export OS_PASSWORD=${cfg.keystoneAdminPassword}
	export OS_TENANT_NAME=${cfg.keystoneAdminTenant}

        # Wait until the keystone is available for use
        count=0
        while ! keystone user-get ${cfg.keystoneAdminUsername} > /dev/null
        do
            if [ $count -eq 30 ]
            then
                echo "Tried 30 times, giving up..."
                exit 1
            fi

            echo "Keystone not yet started. Waiting for 1 second..."
            count=$((count++))
            sleep 1
        done

        # If the service nova doesn't exist, we consider nova
        # is not initialized
        if ! keystone service-get nova
        then
	    keystone service-create --type compute --name nova
	    ID=$(keystone service-get nova | awk '/ id / { print $4 }')
	    keystone endpoint-create --region RegionOne --service $ID --internalurl 'http://localhost:8774/v2/%(tenant_id)s' --adminurl 'http://localhost:8774/v2/%(tenant_id)s' --publicurl 'http://${cfg.endpointPublic}:8774/v2/%(tenant_id)s'

	    keystone user-create --name ${cfg.serviceUsername} --tenant service --pass ${cfg.servicePassword}
	    keystone user-role-add --tenant service --user ${cfg.serviceUsername} --role admin
        fi
        '';
      path = with pkgs; [ cfg.package mysql openssl config.programs.ssh.package "/var/setuid-wrappers/" pkgs.curl pkgs.pythonPackages.keystoneclient pkgs.gawk pkgs.iptables ];
      serviceConfig = {
        PermissionsStartOnly = true; # preStart must be run as root
        TimeoutStartSec = "900"; # 15min for initial db migrations
        # User = "nova";
        # Group = "nova";
        ExecStart = "${cfg.package}/bin/nova-api --config-file=${novaConf}";
      };
    };

    # TODO: it fails to generate CA (probably wrong path)
    /*systemd.services.nova-cert = {
      description = "OpenStack Nova Cert Daemon";
      after = [ "nova-api.service" "rabbitmq.service" "mysql.service" "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ cfg.package mysql openssl ];
      serviceConfig = {
        User = "nova";
        Group = "nova";
        ExecStart = "${cfg.package}/bin/nova-cert --config-file=${novaConf}";
      };
    };*/

    systemd.services.nova-consoleauth = {
      description = "OpenStack Nova ConsoleAuth Daemon";
      after = [ "nova-api.service" "rabbitmq.service" "mysql.service" "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ cfg.package pkgs.mysql pkgs.openssl ];
      serviceConfig = {
        User = "nova";
        Group = "nova";
        ExecStart = "${cfg.package}/bin/nova-consoleauth --config-file=${novaConf}";
      };
    };

    systemd.services.nova-conductor = {
      description = "OpenStack Nova Conductor Daemon";
      after = [ "nova-api.service" "rabbitmq.service" "mysql.service" "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ cfg.package pkgs.mysql pkgs.openssl ];
      serviceConfig = {
        User = "nova";
        Group = "nova";
        ExecStart = "${cfg.package}/bin/nova-conductor --config-file=${novaConf}";
      };
    };

    systemd.services.nova-scheduler = {
      description = "OpenStack Nova Scheduler Daemon";
      after = [ "nova-api.service" "rabbitmq.service" "mysql.service" "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ cfg.package pkgs.mysql pkgs.openssl ];
      serviceConfig = {
        User = "nova";
        Group = "nova";
        ExecStart = "${cfg.package}/bin/nova-scheduler --config-file=${novaConf}";
      };
    };

    virtualisation.libvirtd.enable = true;

    systemd.services.nova-compute = {
      description = "OpenStack Nova Scheduler Daemon";
      after = [ "rabbitmq.service" "mysql.service" "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ cfg.package qemu bridge-utils procps iproute dnsmasq ];
      environment.PYTHONPATH = "${pkgs.pythonPackages.libvirt}/${pkgs.python.sitePackages}";
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/nova-compute --config-file=${novaConf}";
      };
    };
  };
}
