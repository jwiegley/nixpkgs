{ fetchgit }:
[
  {
    goPackagePath = "github.com/hanwen/go-fuse";
    src = fetchgit {
      url = "https://github.com/hanwen/go-fuse";
      rev = "bd746dd8bcc8c059a9d953a786a6156eb83f398e";
      sha256 = "1dvvclp418j3d02v9717sfqhl6fw6yyddr9r3j8gsiv8nb62ib56";
    };
  }
  {
    goPackagePath = "github.com/hanwen/usb";
    src = fetchgit {
      url = "https://github.com/hanwen/usb";
      rev = "69aee4530ac705cec7c5344418d982aaf15cf0b1";
      sha256 = "01k0c2g395j65vm1w37mmrfkg6nm900khjrrizzpmx8f8yf20dky";
    };
  }
]
