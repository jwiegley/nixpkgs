{
  kdeApp, lib,
  extra-cmake-modules, kdoctools,
  kio
}:
kdeApp {
  name = "syndication";
  meta = {
    license = with lib.licenses; [ gpl2 lgpl21 fdl12 ];
    maintainers = [ lib.maintainers.vandenoever ];
  };
  nativeBuildInputs = [ extra-cmake-modules kdoctools ];
  propagatedBuildInputs = [
    kio
  ];
}
