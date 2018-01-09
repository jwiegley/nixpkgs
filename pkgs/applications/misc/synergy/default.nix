{ stdenv, fetchFromGitHub, fetchpatch, cmake, xlibsWrapper, libX11, libXi, libXtst, libXrandr
, xinput, curl, openssl, unzip, writeScriptBin }:

with stdenv.lib;

let certgenScript = writeScriptBin "synergy-generate-certs" ''
  #! ${stdenv.shell}
  set -e -u
  pem=~/.synergy/SSL/Synergy.pem
  fp_file=~/.synergy/SSL/Fingerprints/Local.txt

  mkdir -p ~/.synergy/SSL/Fingerprints
  if [ -e "$pem" ]; then
    echo "$pem already exists; _not_ overwriting it" 1>&2
  else
    ${openssl}/bin/openssl req \
        -x509 -nodes \
        -subj '/CN=Synergy' \
        -newkey rsa:1024 \
        -keyout "$pem" -out "$pem"
    echo "Installed a new cert bundle at $pem" 1>&2
  fi

  fingerprint=$(
    ${openssl}/bin/openssl x509 -fingerprint -sha1 -noout -in "$pem" \
        | cut -d= -f2
  )

  if [ -e "$fp_file" ]; then
    echo "$fp_file already exists; _not_ overwriting it" 1>&2
  else
    echo "$fingerprint" > "$fp_file"
  fi

  fp_verify=$(cat "$fp_file")

  if [ "$fingerprint" != "$fp_verify" ]; then
    echo "$fp_file contents and the actual key fingerprint do not match!" 1>&2
    echo "Please remove it and re-run this script." 1>&2
    exit 1
  fi


  echo "On the synergy _client_ system(s), copy this fingerprint into"\
       "~/.synergy/SSL/Fingerprints/TrustedServers.txt:"
  echo "$fingerprint"
'';

in

stdenv.mkDerivation rec {
  name = "synergy-${version}";
  version = "1.8.8";

  src = fetchFromGitHub {
    owner = "symless";
    repo = "synergy-core";
    rev = "v${version}-stable";
    sha256 = "0ksgr9hkf09h54572p7k7b9zkfhcdb2g2d5x7ixxn028y8i3jyp3";
  };

  patches = [ ./openssl-1.1.patch ];

  patch_gcc6 = fetchpatch {
    url = https://raw.githubusercontent.com/gentoo/gentoo/20e2bff3697ebf5f291e9907b34aae3074a36b53/dev-cpp/gmock/files/gmock-1.7.0-gcc6.patch;
    sha256 = "0j3f381x1lf8qci9pfv6mliggl8qs2w05v5lw3rs3gn7aibg174d";
  };

  postPatch = ''
    ${unzip}/bin/unzip -d ext/gmock-1.6.0 ext/gmock-1.6.0.zip
    ${unzip}/bin/unzip -d ext/gtest-1.6.0 ext/gtest-1.6.0.zip
    patch -d ext/gmock-1.6.0 -p1 -i ${patch_gcc6}
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
    cmake xlibsWrapper libX11 libXi libXtst libXrandr xinput curl openssl
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ../bin/synergyc $out/bin
    cp ../bin/synergys $out/bin
    cp ../bin/synergyd $out/bin
    cp ${certgenScript}/bin/synergy-generate-certs $out/bin
  '';

  doCheck = true;
  checkPhase = "../bin/unittests";

  meta = {
    description = "Share one mouse and keyboard between multiple computers";
    homepage = http://synergy-project.org/;
    license = licenses.gpl2;
    maintainers = [ maintainers.aszlig ];
    platforms = platforms.all;
    broken = stdenv.isDarwin;
  };
}
