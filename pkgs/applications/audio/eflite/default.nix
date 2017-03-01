{stdenv,fetchurl,flite,alsaLib}:

stdenv.mkDerivation rec {
  name = "eflite-${version}";
  version = "0.4.1";
  src = fetchurl {
    url = "https://sourceforge.net/projects/eflite/files/eflite/${version}/${name}.tar.gz";
    sha256 = "088p9w816s02s64grfs28gai3lnibzdjb9d1jwxzr8smbs2qbbci";
  };
  buildInputs = [ flite alsaLib ];
  configureFlags = "flite_dir=${flite} --with-audio=alsa";
  patches = [
    ./buf-overflow
    ./cvs-update
    ./link
  ]; # Patches are taken from debian.

  meta = {
    homepage = http://eflite.sourceforge.net;
    description = "EFlite is a speech server for screen readers";
    longDescription = ''
      EFlite is a speech server for Emacspeak and other screen
      readers that allows them to interface with Festival Lite,
      a free text-to-speech engine developed at the CMU Speech
      Center as an off-shoot of Festival.
    ''; 
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.linux;
    maintainers = with stdenv.lib.maintainers; [ jhhuh ];
  };
}
