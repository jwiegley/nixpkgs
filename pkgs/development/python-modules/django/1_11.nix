{ stdenv, buildPythonPackage, fetchurl, substituteAll,
  pythonOlder,
  geos, gdal, pytz
}:
buildPythonPackage rec {
  pname = "Django";
  name = "${pname}-${version}";
  version = "1.11.3";

  disabled = pythonOlder "2.7";

  src = fetchurl {
    url = "http://www.djangoproject.com/m/releases/1.11/${name}.tar.gz";
    sha256 = "0swgmwnfi6sa5fg5yxcs4k554cj9zp92w5n454xfsibjjl5dxycy";
  };

  patches = [
    (substituteAll {
      src = ./1.10-gis-libs.template.patch;
      geos = geos;
      gdal = gdal;
    })
  ];

  # patch only $out/bin to avoid problems with starter templates (see #3134)
  postFixup = ''
    wrapPythonProgramsIn $out/bin "$out $pythonPath"
  '';

  propagatedBuildInputs = [ pytz ];

  # too complicated to setup
  doCheck = false;

  meta = {
    description = "A high-level Python Web framework";
    homepage = https://www.djangoproject.com/;
  };
}
