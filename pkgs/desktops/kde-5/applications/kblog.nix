{ ecm
, kcalcore
, kcoreaddons
, kdeApp
, kdelibs4support
, kdoctools
, kio
, kxmlrpcclient
, lib
, libical
, syndication
}:

kdeApp {
  name = "kblog";
  meta = {
    description = "A blogging library";
    license = with lib.licenses; [ lgpl21Plus ];
    maintainers = with lib.maintainers; [ vandenoever ];
  };
  nativeBuildInputs = [
    ecm
  ];
  buildInputs = [
    kcalcore
    kcoreaddons
    kdelibs4support
    kdoctools
    kio
    kxmlrpcclient
    libical
    syndication
  ];
}
