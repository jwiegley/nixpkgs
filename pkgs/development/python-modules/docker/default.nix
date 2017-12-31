{ stdenv, buildPythonPackage, fetchurl
, six, requests, websocket_client
, ipaddress, backports_ssl_match_hostname, docker_pycreds
}:
buildPythonPackage rec {
  version = "2.6.1";
  pname = "docker";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://pypi/d/docker/${name}.tar.gz";
    sha256 = "09d3nwcqxhc13l9p6rznd1cnnw004nd1vyz5bcgvmmygnckpahbg";
  };

  propagatedBuildInputs = [
    six
    requests
    websocket_client
    ipaddress
    backports_ssl_match_hostname
    docker_pycreds
  ];

  # Flake8 version conflict
  doCheck = false;

  meta = with stdenv.lib; {
    description = "An API client for docker written in Python";
    homepage = https://github.com/docker/docker-py;
    license = licenses.asl20;
    maintainers = with maintainers; [
      jgeerds
    ];
  };
}
