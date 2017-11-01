# This module defines the global list of uids and gids.  We keep a
# central list to prevent id collisions.

{ config, pkgs, lib, ... }:

{
  options = {

    ids.uids = lib.mkOption {
      internal = true;
      description = ''
        The user IDs used in NixOS.
      '';
    };

    ids.gids = lib.mkOption {
      internal = true;
      description = ''
        The group IDs used in NixOS.
      '';
    };

  };


  config = {

    ids.uids = {
      root = 0;
      #wheel = 1; # unused
      #kmem = 2; # unused
      #tty = 3; # unused
      messagebus = 4; # D-Bus
      haldaemon = 5;
      #disk = 6; # unused
      vsftpd = 7;
      ftp = 8;
      bitlbee = 9;
      avahi = 10;
      nagios = 11;
      atd = 12;
      postfix = 13;
      #postdrop = 14; # unused
      dovecot = 15;
      tomcat = 16;
      #audio = 17; # unused
      #floppy = 18; # unused
      #uucp = 19; # unused
      #lp = 20; # unused
      #proc = 21; # unused
      pulseaudio = 22; # must match `pulseaudio' GID
      gpsd = 23;
      #cdrom = 24; # unused
      #tape = 25; # unused
      #video = 26; # unused
      #dialout = 27; # unused
      polkituser = 28;
      #utmp = 29; # unused
      ddclient = 30;
      davfs2 = 31;
      #disnix = 33; # unused
      osgi = 34;
      tor = 35;
      cups = 36;
      foldingathome = 37;
      sabnzbd = 38;
      #kdm = 39; # dropped in 17.03
      ghostone = 40;
      git = 41;
      fourstore = 42;
      fourstorehttp = 43;
      virtuoso = 44;
      rtkit = 45;
      dovecot2 = 46;
      dovenull2 = 47;
      prayer = 49;
      mpd = 50;
      clamav = 51;
      fprot = 52;
      bind = 53;
      wwwrun = 54;
      #adm = 55; # unused
      spamd = 56;
      #networkmanager = 57; # unused
      nslcd = 58;
      scanner = 59;
      nginx = 60;
      chrony = 61;
      #systemd-journal = 62; # unused
      smtpd = 63;
      smtpq = 64;
      supybot = 65;
      iodined = 66;
      #libvirtd = 67; # unused
      graphite = 68;
      statsd = 69;
      transmission = 70;
      postgres = 71;
      #vboxusers = 72; # unused
      #vboxsf = 73; # unused
      smbguest = 74;  # unused
      varnish = 75;
      datadog = 76;
      lighttpd = 77;
      lightdm = 78;
      freenet = 79;
      ircd = 80;
      bacula = 81;
      almir = 82;
      deluge = 83;
      mysql = 84;
      rabbitmq = 85;
      activemq = 86;
      gnunet = 87;
      oidentd = 88;
      quassel = 89;
      amule = 90;
      minidlna = 91;
      elasticsearch = 92;
      tcpcryptd = 93; # tcpcryptd uses a hard-coded uid. We patch it in Nixpkgs to match this choice.
      firebird = 95;
      #keys = 96; # unused
      haproxy = 97;
      mongodb = 98;
      openldap = 99;
      #users = 100; # unused
      cgminer = 101;
      munin = 102;
      logcheck = 103;
      nix-ssh = 104;
      dictd = 105;
      couchdb = 106;
      searx = 107;
      kippo = 108;
      jenkins = 109;
      systemd-journal-gateway = 110;
      #notbit = 111; # unused
      ngircd = 112;
      btsync = 113;
      minecraft = 114;
      #monetdb = 115; # unused (not packaged), removed 2016-09-19
      vault = 115;
      rippled = 116;
      murmur = 117;
      foundationdb = 118;
      newrelic = 119;
      starbound = 120;
      hydra = 122;
      spiped = 123;
      teamspeak = 124;
      influxdb = 125;
      nsd = 126;
      gitolite = 127;
      znc = 128;
      polipo = 129;
      mopidy = 130;
      #docker = 131; # unused
      gdm = 132;
      dhcpd = 133;
      siproxd = 134;
      mlmmj = 135;
      neo4j = 136;
      riemann = 137;
      riemanndash = 138;
      radvd = 139;
      zookeeper = 140;
      dnsmasq = 141;
      uhub = 142;
      yandexdisk = 143;
      #collectd = 144; #unused
      consul = 145;
      mailpile = 146;
      redmine = 147;
      seeks = 148;
      prosody = 149;
      i2pd = 150;
      systemd-network = 152;
      systemd-resolve = 153;
      systemd-timesync = 154;
      liquidsoap = 155;
      etcd = 156;
      hbase = 158;
      opentsdb = 159;
      scollector = 160;
      bosun = 161;
      kubernetes = 162;
      peerflix = 163;
      chronos = 164;
      gitlab = 165;
      tox-bootstrapd = 166;
      cadvisor = 167;
      nylon = 168;
      apache-kafka = 169;
      panamax = 170;
      exim = 172;
      #fleet = 173; # unused
      #input = 174; # unused
      sddm = 175;
      tss = 176;
      memcached = 177;
      ntp = 179;
      zabbix = 180;
      redis = 181;
      unifi = 183;
      uptimed = 184;
      zope2 = 185;
      ripple-data-api = 186;
      mediatomb = 187;
      rdnssd = 188;
      ihaskell = 189;
      i2p = 190;
      lambdabot = 191;
      asterisk = 192;
      plex = 193;
      plexpy = 195;
      grafana = 196;
      skydns = 197;
      # ripple-rest = 198; # unused, removed 2017-08-12
      nix-serve = 199;
      tvheadend = 200;
      uwsgi = 201;
      gitit = 202;
      riemanntools = 203;
      subsonic = 204;
      riak = 205;
      shout = 206;
      gateone = 207;
      namecoin = 208;
      dnschain = 209;
      #lxd = 210; # unused
      kibana = 211;
      xtreemfs = 212;
      calibre-server = 213;
      heapster = 214;
      bepasty = 215;
      pumpio = 216;
      nm-openvpn = 217;
      mathics = 218;
      ejabberd = 219;
      postsrsd = 220;
      opendkim = 221;
      dspam = 222;
      gale = 223;
      matrix-synapse = 224;
      rspamd = 225;
      rmilter = 226;
      cfdyndns = 227;
      gammu-smsd = 228;
      pdnsd = 229;
      octoprint = 230;
      avahi-autoipd = 231;
      nntp-proxy = 232;
      mjpg-streamer = 233;
      radicale = 234;
      hydra-queue-runner = 235;
      hydra-www = 236;
      syncthing = 237;
      caddy = 239;
      taskd = 240;
      factorio = 241;
      emby = 242;
      graylog = 243;
      sniproxy = 244;
      nzbget = 245;
      mosquitto = 246;
      toxvpn = 247;
      squeezelite = 248;
      turnserver = 249;
      smokeping = 250;
      gocd-agent = 251;
      gocd-server = 252;
      terraria = 253;
      mattermost = 254;
      prometheus = 255;
      telegraf = 256;
      gitlab-runner = 257;
      postgrey = 258;
      hound = 259;
      leaps = 260;
      ipfs  = 261;
      stanchion = 262;
      riak-cs = 263;
      infinoted = 264;
      # keystone = 265; # unused, removed 2017-12-13
      # glance = 266; # unused, removed 2017-12-13
      couchpotato = 267;
      gogs = 268;
      pdns-recursor = 269;
      kresd = 270;
      rpc = 271;
      geoip = 272;
      fcron = 273;
      sonarr = 274;
      radarr = 275;
      jackett = 276;
      aria2 = 277;
      clickhouse = 278;
      rslsync = 279;
      minio = 280;
      kanboard = 281;
      pykms = 282;
      kodi = 283;
      restya-board = 284;
      tuntox = 285;

      # When adding a uid, make sure it doesn't match an existing gid. And don't use uids above 399!

      nixbld = 30000; # start of range of uids
      nobody = 65534;
    };

    ids.gids = {
      root = 0;
      wheel = 1;
      kmem = 2;
      tty = 3;
      messagebus = 4; # D-Bus
      haldaemon = 5;
      disk = 6;
      vsftpd = 7;
      ftp = 8;
      bitlbee = 9;
      avahi = 10;
      #nagios = 11; # unused
      atd = 12;
      postfix = 13;
      postdrop = 14;
      dovecot = 15;
      tomcat = 16;
      audio = 17;
      floppy = 18;
      uucp = 19;
      lp = 20;
      proc = 21;
      pulseaudio = 22; # must match `pulseaudio' UID
      gpsd = 23;
      cdrom = 24;
      tape = 25;
      video = 26;
      dialout = 27;
      #polkituser = 28; # currently unused, polkitd doesn't need a group
      utmp = 29;
      ddclient = 30;
      davfs2 = 31;
      disnix = 33;
      osgi = 34;
      tor = 35;
      #cups = 36; # unused
      #foldingathome = 37; # unused
      #sabnzd = 38; # unused
      #kdm = 39; # unused, even before 17.03
      ghostone = 40;
      git = 41;
      fourstore = 42;
      fourstorehttp = 43;
      virtuoso = 44;
      #rtkit = 45; # unused
      dovecot2 = 46;
      #dovenull = 47; # unused
      prayer = 49;
      mpd = 50;
      clamav = 51;
      fprot = 52;
      #bind = 53; # unused
      wwwrun = 54;
      adm = 55;
      spamd = 56;
      networkmanager = 57;
      nslcd = 58;
      scanner = 59;
      nginx = 60;
      chrony = 61;
      systemd-journal = 62;
      smtpd = 63;
      smtpq = 64;
      supybot = 65;
      iodined = 66;
      libvirtd = 67;
      graphite = 68;
      #statsd = 69; # unused
      transmission = 70;
      postgres = 71;
      vboxusers = 72;
      vboxsf = 73;
      smbguest = 74;  # unused
      varnish = 75;
      datadog = 76;
      lighttpd = 77;
      lightdm = 78;
      freenet = 79;
      ircd = 80;
      bacula = 81;
      almir = 82;
      deluge = 83;
      mysql = 84;
      rabbitmq = 85;
      activemq = 86;
      gnunet = 87;
      oidentd = 88;
      quassel = 89;
      amule = 90;
      minidlna = 91;
      elasticsearch = 92;
      #tcpcryptd = 93; # unused
      firebird = 95;
      keys = 96;
      haproxy = 97;
      #mongodb = 98; # unused
      openldap = 99;
      munin = 102;
      #logcheck = 103; # unused
      #nix-ssh = 104; # unused
      dictd = 105;
      couchdb = 106;
      searx = 107;
      kippo = 108;
      jenkins = 109;
      systemd-journal-gateway = 110;
      #notbit = 111; # unused
      #ngircd = 112; # unused
      btsync = 113;
      #minecraft = 114; # unused
      #monetdb = 115; # unused (not packaged), removed 2016-09-19
      vault = 115;
      #ripped = 116; # unused
      #murmur = 117; # unused
      foundationdb = 118;
      newrelic = 119;
      starbound = 120;
      hydra = 122;
      spiped = 123;
      teamspeak = 124;
      influxdb = 125;
      nsd = 126;
      gitolite = 127;
      znc = 128;
      polipo = 129;
      mopidy = 130;
      docker = 131;
      gdm = 132;
      #dhcpcd = 133; # unused
      siproxd = 134;
      mlmmj = 135;
      #neo4j = 136; # unused
      riemann = 137;
      riemanndash = 138;
      #radvd = 139; # unused
      #zookeeper = 140; # unused
      #dnsmasq = 141; # unused
      uhub = 142;
      #yandexdisk = 143; # unused
      #collectd = 144; # unused
      #consul = 145; # unused
      mailpile = 146;
      redmine = 147;
      seeks = 148;
      prosody = 149;
      i2pd = 150;
      systemd-network = 152;
      systemd-resolve = 153;
      systemd-timesync = 154;
      liquidsoap = 155;
      #etcd = 156; # unused
      hbase = 158;
      opentsdb = 159;
      scollector = 160;
      bosun = 161;
      kubernetes = 162;
      #peerflix = 163; # unused
      #chronos = 164; # unused
      gitlab = 165;
      nylon = 168;
      panamax = 170;
      exim = 172;
      fleet = 173;
      input = 174;
      sddm = 175;
      tss = 176;
      #memcached = 177; # unused
      #ntp = 179; # unused
      #zabbix = 180; # unused
      #redis = 181; # unused
      #unifi = 183; # unused
      #uptimed = 184; # unused
      #zope2 = 185; # unused
      #ripple-data-api = 186; #unused
      mediatomb = 187;
      #rdnssd = 188; # unused
      ihaskell = 189;
      i2p = 190;
      lambdabot = 191;
      asterisk = 192;
      plex = 193;
      sabnzbd = 194;
      #grafana = 196; #unused
      #skydns = 197; #unused
      # ripple-rest = 198; # unused, removed 2017-08-12
      #nix-serve = 199; #unused
      #tvheadend = 200; #unused
      uwsgi = 201;
      gitit = 202;
      riemanntools = 203;
      subsonic = 204;
      riak = 205;
      #shout = 206; #unused
      gateone = 207;
      namecoin = 208;
      #dnschain = 209; #unused
      lxd = 210; # unused
      #kibana = 211;
      xtreemfs = 212;
      calibre-server = 213;
      bepasty = 215;
      pumpio = 216;
      nm-openvpn = 217;
      mathics = 218;
      ejabberd = 219;
      postsrsd = 220;
      opendkim = 221;
      dspam = 222;
      gale = 223;
      matrix-synapse = 224;
      rspamd = 225;
      rmilter = 226;
      cfdyndns = 227;
      pdnsd = 229;
      octoprint = 230;
      radicale = 234;
      syncthing = 237;
      caddy = 239;
      taskd = 240;
      factorio = 241;
      emby = 242;
      sniproxy = 244;
      nzbget = 245;
      mosquitto = 246;
      #toxvpn = 247; # unused
      #squeezelite = 248; #unused
      turnserver = 249;
      smokeping = 250;
      gocd-agent = 251;
      gocd-server = 252;
      terraria = 253;
      mattermost = 254;
      prometheus = 255;
      #telegraf = 256; # unused
      gitlab-runner = 257;
      postgrey = 258;
      hound = 259;
      leaps = 260;
      ipfs = 261;
      stanchion = 262;
      riak-cs = 263;
      infinoted = 264;
      # keystone = 265; # unused, removed 2017-12-13
      # glance = 266; # unused, removed 2017-12-13
      couchpotato = 267;
      gogs = 268;
      kresd = 270;
      #rpc = 271; # unused
      #geoip = 272; # unused
      fcron = 273;
      sonarr = 274;
      radarr = 275;
      jackett = 276;
      aria2 = 277;
      clickhouse = 278;
      rslsync = 279;
      minio = 280;
      kanboard = 281;
      pykms = 282;
      kodi = 283;
      restya-board = 284;

      # When adding a gid, make sure it doesn't match an existing
      # uid. Users and groups with the same name should have equal
      # uids and gids. Also, don't use gids above 399!

      users = 100;
      nixbld = 30000;
      nogroup = 65534;
    };

  };

}
