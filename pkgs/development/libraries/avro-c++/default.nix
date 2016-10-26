{ stdenv, fetchurl, cmake, boost, pythonPackages, llvmPackages
, libcxxSupport ? false
}:

let version = "1.8.1"; in

stdenv.mkDerivation {
  name = "avro-c++-${version}";

  src = fetchurl {
    url = "mirror://apache/avro/avro-${version}/cpp/avro-cpp-${version}.tar.gz";
    sha256 = "6559755ac525e908e42a2aa43444576cba91e522fe989088ee7f70c169bcc403";
  };

  buildInputs = [
    cmake
    boost
    pythonPackages.python
  ] ++ stdenv.lib.optionals libcxxSupport [ llvmPackages.clang llvmPackages.libcxx llvmPackages.libcxxabi ];

  preConfigure = ''
    substituteInPlace test/SchemaTests.cc --replace "BOOST_CHECKPOINT" "BOOST_TEST_CHECKPOINT"
    substituteInPlace test/buffertest.cc --replace "BOOST_MESSAGE" "BOOST_TEST_MESSAGE"
  '' + stdenv.lib.optionalString libcxxSupport ''
    export CXX=clang++
    export CXXFLAGS="-nostdinc++ -I${llvmPackages.libcxx}/include/c++/v1"
  '';

  enableParallelBuilding = true;

  meta = {
    description = "A C++ library which implements parts of the Avro Specification";
    homepage = https://avro.apache.org/;
    license = stdenv.lib.licenses.asl20;
    maintainers = with stdenv.lib.maintainers; [ rasendubi ];
    platforms = stdenv.lib.platforms.all;
  };
}
