{ stdenv,
fetchFromGitHub, fetchpatch,
webos, cmake, pkgconfig,
libusb }:

stdenv.mkDerivation rec {
  name = "novacomd-${version}";
  version = "127";

  src = fetchFromGitHub {
    owner = "openwebos";
    repo = "novacomd";
    rev = "submissions/${version}";
    sha256 = "1gahc8bvvvs4d6svrsw24iw5r0mhy4a2ars3j2gz6mp6sh42bznl";
  };

  patches = [
    (fetchpatch {
      url = "https://aur.archlinux.org/cgit/aur.git/plain/0001-Use-usb_bulk_-read-write-instead-of-homemade-handler.patch?h=palm-novacom-git";
      sha256 = "116r6p4l767fqxfvq03sy6v7vxja8pkxlrc5hqby351a40b5dkiv";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/feniksa/webos-overlay/40e2c113fc9426d50bdf37779da57ce4ff06ee6e/net-misc/novacomd/files/0011-Remove-verbose-output.patch";
      sha256 = "09lmv06ziwkfg19b1h3jsmkm6g1f0nxxq1717dircjx8m45ypjq9";
    })
  ];

  nativeBuildInputs = [ cmake pkgconfig webos.cmake-modules ];

  buildInputs = [ libusb ];

  cmakeFlags = [ "-DWEBOS_TARGET_MACHINE_IMPL=host" ];

  meta = with stdenv.lib; {
    description = "Daemon for communicating with WebOS devices";
    license = licenses.asl20;
    maintainers = with maintainers; [ dtzWill ];
    platforms = platforms.linux;
  };
}
