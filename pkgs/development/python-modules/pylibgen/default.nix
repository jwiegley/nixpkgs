{ pythonPackages, fetchPypi , python , stdenv }:

pythonPackages.buildPythonPackage rec {
  pname = "pylibgen";
  version = "1.3.0";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "16hj4x1j490w0wnrqv1la0jlbywiv3fx7ps62i008djbampc9li9";
  };

  propagatedBuildInputs = with pythonPackages; [
    requests
  ];

  meta = {
    homepage    = "https://github.com/JoshuaRLi/pylibgen";
    description = "Programmatic Python interface for Library Genesis";
    license     = stdenv.lib.licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ matthiasbeyer ];
  };
}


