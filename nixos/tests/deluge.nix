import ./make-test.nix ({ pkgs, ...} : {
  name = "deluge";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ flokli ];
  };

  nodes = {
    server =
      { pkgs, config, ... }:

      { services.deluge = {
          enable = true;
          web.enable = true;
        };
        networking.firewall.allowedTCPPorts = [ 8112 ];
      };

    client = { };
  };

  testScript = ''
    startAll;

    $server->waitForUnit("deluged");
    $server->waitForUnit("delugeweb");
    $server->waitUntilSucceeds("deluge-console info");
    $client->waitForUnit("network.target");
    $client->waitUntilSucceeds("curl --fail http://server:8112");
  '';
})
