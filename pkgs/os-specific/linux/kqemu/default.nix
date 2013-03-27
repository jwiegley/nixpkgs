{ stdenv, fetchurl, kernel, perl }:

stdenv.mkDerivation rec {
  name = "kqemu-1.4.0pre1-${kernel.version}";
  
  src = fetchurl {
    url = "http://www.nongnu.org/qemu/${name}.tar.gz";
    sha256 = "14dlmawn3gia1j401ag5si5k1a1vav7jpv86rl37p1hwmr7fihxs";
  };

  buildInputs = [ perl ];
  
  configureFlags = [ ''--PREFIX=$out'' ''--kernel-path=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build)'' ];
  
  preConfigure = '' 
    sed -e '/#include/i#include <linux/sched.h>' -i kqemu-linux.c

    sed -e 's/memset/mymemset/g; s/memcpy/mymemcpy/g; s/void [*]my/static void *my/g' -i common/kernel.c
    sed -e 's/`uname -r`/${kernel.modDirVersion}/' -i install.sh
    sed -e '/kernel_path=/akernel_path=$out$kernel_path' -i install.sh
    sed -e '/depmod/d' -i install.sh
    cat install.sh
  '';

  meta = {
    description = "Kernel module for QEMU acceleration";
  }; 
}
