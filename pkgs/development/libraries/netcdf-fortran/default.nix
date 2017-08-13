{ stdenv, fetchurl, netcdf, hdf5, curl, gfortran }:
stdenv.mkDerivation rec {
  name = "netcdf-fortran-${version}";
  version = "4.4.3";

  src = fetchurl {
    url = "https://github.com/Unidata/netcdf-fortran/archive/v${version}.tar.gz";
    sha256 = "4170fc018c9ee8222e317215c6a273542623185f5f6ee00d37bbb4e024e4e998";
  };

  buildInputs = [ netcdf hdf5 curl gfortran ];
  doCheck = true;

  passthru = {
    inherit hdf5;
  };

  meta = with stdenv.lib; {
    description = "Fortran API to manipulate netcdf files";
    homepage = http://www.unidata.ucar.edu/software/netcdf/;
    license = licenses.free;
    maintainers = [ maintainers.bzizou ];
    platforms = platforms.unix;
  };
}
