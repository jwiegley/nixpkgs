{ qtSubmodule, qtbase, qtdeclarative }:

qtSubmodule {
  name = "qtwebsockets";
  qtInputs = [ qtbase qtdeclarative ];
}
