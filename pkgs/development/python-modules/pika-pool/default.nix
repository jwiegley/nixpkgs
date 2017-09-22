{ stdenv, buildPythonPackage, fetchPypi
, pika
}:

buildPythonPackage rec {
  pname = "pika-pool";
  version = "0.1.3";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "f3985888cc2788cdbd293a68a8b5702a9c955db6f7b8b551aeac91e7f32da397";
  };

  # Tests require database connections
  doCheck = false;

  propagatedBuildInputs = [ pika ];
  meta = with stdenv.lib; {
    homepage = https://github.com/bninja/pika-pool;
    license = licenses.bsdOriginal;
    description = "Pools for pikas.";
  };
}
