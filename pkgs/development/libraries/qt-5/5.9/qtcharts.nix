{ qtSubmodule, qtbase, qtdeclarative }:

qtSubmodule {
  name = "qtcharts";
  qtInputs = [ qtbase qtdeclarative ];
  outputs = [ "bin" "dev" "out" ];
  postInstall = ''
    moveToOutput "$qtQmlPrefix" "$bin"
  '';
}
