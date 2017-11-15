{ stdenv, fetchFromGitHub }:

## Usage
# In NixOS, simply add this package to services.udev.packages:
#   services.udev.packages = [ pkgs.android-udev-rules ];

stdenv.mkDerivation rec {
  name = "android-udev-rules-${version}";
  version = "20171113";

  src = fetchFromGitHub {
    owner = "M0Rf30";
    repo = "android-udev-rules";
    rev = version;
    sha256 = "11gcnk6wjc2sw05hwi4xphvx9ksmkpvsdziaczymqxkaads3f1dy";
  };

  installPhase = ''
    install -D 51-android.rules $out/etc/udev/rules.d/51-android.rules
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/M0Rf30/android-udev-rules;
    description = "Android udev rules list aimed to be the most comprehensive on the net";
    platforms = platforms.linux;
    license = licenses.gpl3;
    maintainers = with maintainers; [ abbradar ];
  };
}
