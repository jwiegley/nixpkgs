{ ecm
, grantlee
, kdeApp
, ki18n
, kiconthemes
, knewstuff
, lib
}:

kdeApp {
  name = "grantleetheme";
  meta = {
    license = with lib.licenses; [ lgpl2 ];
    maintainers = with lib.maintainers; [ vandenoever ];
  };
  nativeBuildInputs = [
    ecm
  ];
  buildInputs = [
    grantlee
    ki18n
    kiconthemes
    knewstuff
  ];
}
