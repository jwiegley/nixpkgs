{ fetchurl, stdenv, cmake, qt4
, hdf5
, mpich2
, python
, libxml2
, mesa, libXt
}:

stdenv.mkDerivation rec {
  name = "paraview-4.0.1";
  src = fetchurl {
    url = "http://paraview.org/files/v4.0/ParaView-v4.0.1-source.tgz";
    sha256 = "1qj8dq8gqpsw75sv4sdc7xm1xcpv0ilsddnrcfhha0zfhp0gq10y";
  };

  # [  5%] Generating vtkGLSLShaderLibrary.h
  # ../../../bin/ProcessShader: error while loading shared libraries: libvtksys.so.pv3.10: cannot open shared object file: No such file or directory
  preConfigure = ''
    export NIX_LDFLAGS="$NIX_LDFLAGS -rpath $out/lib/paraview-3.98 -rpath ../../../../../../lib -rpath ../../../../../lib -rpath ../../../../lib -rpath ../../../lib -rpath ../../lib -rpath ../lib"
  '';
  cmakeFlags = {
    PARAVIEW_USE_SYSTEM_HDF5 = true;
    VTK_USE_SYSTEM_LIBXML2 = true;
    PARAVIEW_ENABLE_PYTHON = true;
    # use PARAVIEW_INSTALL_THIRD_PARTY_LIBRARIES = false
    # to fix make install error:
    # http://www.cmake.org/pipermail/paraview/2011-February/020268.html
    PARAVIEW_INSTALL_THIRD_PARTY_LIBRARIES = false;
    CMAKE_SKIP_BUILD_RPATH = true;
    VTK_USE_RPATH = true;
    PARAVIEW_INSTALL_DEVELOPMENT = true;
  };

  # https://bugzilla.redhat.com/show_bug.cgi?id=1138466
  NIX_CFLAGS_COMPILE = "-DGLX_GLXEXT_LEGACY";

  enableParallelBuilding = true;

  buildInputs = [ cmake qt4 hdf5 mpich2 python libxml2 mesa libXt ];

  meta = {
    homepage = "http://www.paraview.org/";
    description = "3D Data analysis and visualization application";
    license = stdenv.lib.licenses.free;
    maintainers = with stdenv.lib.maintainers; [viric guibert];
    platforms = with stdenv.lib.platforms; linux;
  };
}
