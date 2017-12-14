{ stdenv, fetchurl, pkgconfig, expat, ncurses, pciutils, numactl
, cairo, libX11
, x11Support ? (!stdenv.isCygwin)
}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "hwloc-1.11.8";

  src = fetchurl {
    url = "http://www.open-mpi.org/software/hwloc/v1.11/downloads/${name}.tar.bz2";
    sha256 = "0karxv4r1r8sa7ki5aamlxdvyvz0bvzq4gdhq0yi5nc4a0k11vzc";
  };

  hardeningDisable = [ "format" ];

  configureFlags = [
    "--localstatedir=/var"
  ];

  # XXX: libX11 is not directly needed, but needed as a propagated dep of Cairo.
  nativeBuildInputs = [ pkgconfig ];

  # Filter out `null' inputs.  This allows users to `.override' the
  # derivation and set optional dependencies to `null'.
  buildInputs = stdenv.lib.filter (x: x != null)
   ([ expat ncurses ]
     ++  (optionals x11Support [ cairo libX11 ])
     ++  (optionals stdenv.isLinux [ numactl ]));

  propagatedBuildInputs =
    # Since `libpci' appears in `hwloc.pc', it must be propagated.
    optional stdenv.isLinux pciutils;

  enableParallelBuilding = true;

  postInstall =
    optionalString (stdenv.isLinux && numactl != null)
      '' if [ -d "${numactl}/lib64" ]
         then
             numalibdir="${numactl}/lib64"
         else
             numalibdir="${numactl}/lib"
             test -d "$numalibdir"
         fi

         sed -i "$lib/lib/libhwloc.la" \
             -e "s|-lnuma|-L$numalibdir -lnuma|g"
      '';

  # Checks disabled because they're impure (hardware dependent) and
  # fail on some build machines.
  doCheck = false;

  outputs = [ "out" "lib" "dev" "doc" "man" ];

  meta = {
    description = "Portable abstraction of hierarchical architectures for high-performance computing";
    longDescription = ''
       hwloc provides a portable abstraction (across OS,
       versions, architectures, ...) of the hierarchical topology of
       modern architectures, including NUMA memory nodes, sockets,
       shared caches, cores and simultaneous multithreading.  It also
       gathers various attributes such as cache and memory
       information.  It primarily aims at helping high-performance
       computing applications with gathering information about the
       hardware so as to exploit it accordingly and efficiently.

       hwloc may display the topology in multiple convenient
       formats.  It also offers a powerful programming interface to
       gather information about the hardware, bind processes, and much
       more.
    '';

    # http://www.open-mpi.org/projects/hwloc/license.php
    license = licenses.bsd3;
    homepage = http://www.open-mpi.org/projects/hwloc/;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
