{ stdenv, fetchFromGitHub, cmake, xlibsWrapper, libX11, libXi, libXtst, libXrandr
, xinput, curl, libssl, unzip }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "synergy-${version}";
  version = "1.7.4";

  src = fetchFromGitHub {
    owner = "synergy";
    repo = "synergy";
    rev = "v${version}-stable";
    sha256 = "0pxj0qpnsaffpaxik8vc5rjfinmx8ab3b2lssrxkfbs7isskvs33";
  };

  postPatch = ''
    ${unzip}/bin/unzip -d ext/gmock-1.6.0 ext/gmock-1.6.0.zip
    ${unzip}/bin/unzip -d ext/gtest-1.6.0 ext/gtest-1.6.0.zip
  ''
    # We have XRRNotifyEvent (libXrandr), but with the upstream CMakeLists.txt
    # it's not able to find it (it's trying to search the store path of libX11
    # instead) and we don't get XRandR support, even though the CMake output
    # _seems_ to say so:
    #
    #   Looking for XRRQueryExtension in Xrandr - found
    #
    # The relevant part however is:
    #
    #   Looking for XRRNotifyEvent - not found
    #
    # So let's force it:
  + optionalString stdenv.isLinux ''
    sed -i -e '/HAVE_X11_EXTENSIONS_XRANDR_H/c \
      set(HAVE_X11_EXTENSIONS_XRANDR_H true)
    ' CMakeLists.txt
  '';

  buildInputs = [
    cmake xlibsWrapper libX11 libXi libXtst libXrandr xinput curl libssl
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ../bin/synergyc $out/bin
    cp ../bin/synergys $out/bin
    cp ../bin/synergyd $out/bin
  '';

  doCheck = true;
  checkPhase = "../bin/unittests";

  meta = {
    description = "Share one mouse and keyboard between multiple computers";
    homepage = "http://synergy-project.org/";
    license = licenses.gpl2;
    maintainers = [ maintainers.aszlig ];
    platforms = platforms.all;
  };
}
