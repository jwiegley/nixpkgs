# This file was generated by go2nix.
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "azure-vhd-utils-${version}";
  version = "20160614-${stdenv.lib.strings.substring 0 7 rev}";
  rev = "070db2d701a462ca2edcf89d677ed3cac309d8e8";

  goPackagePath = "github.com/Microsoft/azure-vhd-utils";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/Microsoft/azure-vhd-utils";
    sha256 = "0b9kbavlb92rhnb1swwq8bdn4l9a994rmf1ywyfq4yc0kd3gnhgh";
  };

  goDeps = ./deps.nix;

  meta = with stdenv.lib; {
    homepage = https://github.com/Microsoft/azure-vhd-utils;
    description = "Read, inspect and upload VHD files for Azure";
    longDescription = "Go package to read Virtual Hard Disk (VHD) file, a CLI interface to upload local VHD to Azure storage and to inspect a local VHD";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}

