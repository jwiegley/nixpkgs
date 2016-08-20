
{ stdenv, fetchurl, cmake,
  singlePrec ? true,
  mpiEnabled ? false,
  fftw,
  openmpi
}:


stdenv.mkDerivation {
  name = "gromacs-4.6.7";

  src = fetchurl {
    url = "ftp://ftp.gromacs.org/pub/gromacs/gromacs-4.6.7.tar.gz";
    sha256 = "6afb1837e363192043de34b188ca3cf83db6bd189601f2001a1fc5b0b2a214d9";
  };

  buildInputs = [cmake fftw]
  ++ (stdenv.lib.optionals mpiEnabled [ openmpi ]);

  cmakeFlags = with stdenv.lib; {
    GMX_DOUBLE = !singlePrec;
    GMX_MPI = mpiEnabled;
  } // (optionalAttrs (!singlePrec) {
    GMX_DEFAULT_SUFFIX = false;
  }) // (optionalAttrs mpiEnabled {
    GMX_CPU_ACCELERATION = "SSE4.1";
    GMX_OPENMP = true;
    GMX_THREAD_MPI = false;
  });

  meta = with stdenv.lib; {
    homepage    = "http://www.gromacs.org";
    license     = licenses.gpl2;
    description = "Molecular dynamics software package";
    longDescription = ''
      GROMACS is a versatile package to perform molecular dynamics,
      i.e. simulate the Newtonian equations of motion for systems
      with hundreds to millions of particles.

      It is primarily designed for biochemical molecules like
      proteins, lipids and nucleic acids that have a lot of
      complicated bonded interactions, but since GROMACS is
      extremely fast at calculating the nonbonded interactions (that
      usually dominate simulations) many groups are also using it
      for research on non-biological systems, e.g. polymers.

      GROMACS supports all the usual algorithms you expect from a
      modern molecular dynamics implementation, (check the online
      reference or manual for details), but there are also quite a
      few features that make it stand out from the competition.

      See: http://www.gromacs.org/About_Gromacs for details.
    '';
    platforms = platforms.unix;
  };
}
