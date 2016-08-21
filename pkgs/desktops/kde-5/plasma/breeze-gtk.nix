{ plasmaPackage
, ecm
}:

plasmaPackage {
  name = "breeze-gtk";
  nativeBuildInputs = [ ecm ];
  cmakeFlags = { WITH_GTK3_VERSION = "3.20"; };
}
