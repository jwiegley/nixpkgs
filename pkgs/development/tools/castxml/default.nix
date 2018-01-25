{ stdenv, fetchFromGitHub
, pythonPackages
, pkgconfig
, cmake , llvmPackages, zlib, ncurses
, clang
, withMan ? true
}:

let
  clangInc = "${llvmPackages.clang-unwrapped.out}/include";
  clangLib = "${llvmPackages.clang-unwrapped.out}/lib";

  libterminfo = stdenv.mkDerivation {
    name = "tinfo";
    unpackPhase = ":"; # aka we don't need 'src'
    propagatedBuildInputs = [ ncurses ];
    installPhase = ''
      mkdir -pv $out/lib
      cp -rv ${ncurses.out}/lib $out/
      mv $out/lib/libncurses.so $out/lib/libtinfo.so
    '';
  };
in
stdenv.mkDerivation rec {
  propagatedbuildInputs = [ llvmPackages.llvm libterminfo zlib ];

  name    = "${pname}-${version}";
  pname   = "CastXML";
  # there is no tag, master is considered stable at all times
  version = "20171003";

  src = fetchFromGitHub {
    owner  = "CastXML";
    repo   = "CastXML";
    rev    = "ae62b1a29c8233c3dd40fc3e293ddcdbe0bdcccc";
    sha256 = "1z2qc5arga5vn6m1j2wp1rhrsw4dkrzrdjjslxy9q9n5gv247fh6";
  };

  buildInputs = [ cmake pkgconfig ] ++ stdenv.lib.optionals withMan [ pythonPackages.sphinx ];

  preConfigure = ''
    substituteInPlace CMakeLists.txt --replace \
      'foreach(inc ''${LLVM_INCLUDE_DIRS})' 'foreach(inc ${clangInc})'

    substituteInPlace src/RunClang.cxx \
      --replace 'args.push_back("-nobuiltininc");' '// args.push_back("-nobuiltininc"); commented out by nixos' \
      --replace 'args.push_back("-nostdlibinc");' '// args.push_back("-nostdlibinc"); commented out by nixos'

    export CMAKE_PREFIX_PATH="$CMAKE_PREFIX_PATH:${llvmPackages.llvm}"

    cmakeFlagsArray+=(
    -DCMAKE_PREFIX_PATH="${llvmPackages.clang-unwrapped.out}"
    -DCMAKE_CXX_FLAGS="-I${clangInc}"
     -DCMAKE_EXE_LINKER_FLAGS="-L${clangLib} -L${libterminfo}/lib -L${zlib.out}/lib"
     ${if withMan then "-DSPHINX_MAN=ON" else ""}
     # may be needed -DSPHINX_EXECUTABLE}
  )'';

  doCheck=true;
  checkPhase = ''
    # -E exclude 4 tests based on names
    # see https://github.com/CastXML/CastXML/issues/90
    ctest -E 'cmd.cc-(gnu|msvc)-((c-src-c)|(src-cxx))-cmd'
  '';

  meta = with stdenv.lib; {
    homepage = http://www.kitware.com;
    license = licenses.asl20;
    description = "Abstract syntax tree XML output tool";
    platforms = platforms.unix;
  };
}
