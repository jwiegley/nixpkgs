{ kde, kdelibs, subversionClient, apr, aprutil,perl }:

kde {

  buildInputs = [ kdelibs subversionClient apr aprutil perl ];

  cmakeFlags = { BUILD_perldoc = true; };

  meta = {
    description = "Subversion and perldoc kioslaves";
  };
}
