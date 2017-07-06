{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "consul_exporter-${version}";
  version = "0.3.0";
  rev = "v${version}";

  goPackagePath = "github.com/prometheus/consul_exporter";

  src = fetchFromGitHub {
    inherit rev;
    owner = "prometheus";
    repo = "consul_exporter";
    sha256 = "1zffbxyfmqpbdqkx5rb5vjgd9j4p4zcrh6jvn1zhbdzrcs7khnd9";
  };

  meta = with stdenv.lib; {
    description = "Prometheus exporter for Consul metrics";
    homepage = https://github.com/prometheus/consul_exporter;
    license = licenses.asl20;
    maintainers = with maintainers; [ hectorj ];
    platforms = platforms.unix;
  };
}
