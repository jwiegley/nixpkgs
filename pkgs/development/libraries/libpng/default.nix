{ stdenv, fetchurl, zlib, apngSupport ? true }:

assert zlib != null;

let
  version = "1.6.30";
  patchVersion = "1.6.30";
  # patchVersion = version;
  sha256 = "0rin6la7q03vb7wsafhlvzqri1v9ky30g4ljsfcwa37pzwpk6z16";
  patch_src = fetchurl {
    url = "mirror://sourceforge/libpng-apng/libpng-${patchVersion}-apng.patch.gz";
    sha256 = "06nrcp2n77f563hch8g9gv62jg894mvya6zizj5fsmbqzaqmjqqs";
  };
  whenPatched = stdenv.lib.optionalString apngSupport;

in stdenv.mkDerivation rec {
  name = "libpng" + whenPatched "-apng" + "-${version}";

  src = fetchurl {
    url = "mirror://sourceforge/libpng/libpng-${version}.tar.xz";
    inherit sha256;
  };
  postPatch = whenPatched "gunzip < ${patch_src} | patch -Np1";

  outputs = [ "out" "dev" "man" ];
  outputBin = "dev";

  propagatedBuildInputs = [ zlib ];

  # it's hard to cross-run tests and some check programs didn't compile anyway
  makeFlags = stdenv.lib.optional (!doCheck) "check_PROGRAMS=";
  doCheck = ! stdenv ? cross;

  passthru = { inherit zlib; };

  meta = with stdenv.lib; {
    description = "The official reference implementation for the PNG file format" + whenPatched " with animation patch";
    homepage = http://www.libpng.org/pub/png/libpng.html;
    license = licenses.libpng;
    platforms = platforms.all;
    maintainers = [ maintainers.vcunat maintainers.fuuzetsu ];
  };
}
