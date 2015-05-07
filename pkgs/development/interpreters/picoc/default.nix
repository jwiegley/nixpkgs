{ stdenv, fetchFromGitHub, readline }:

let version = "2015-05-04"; in
stdenv.mkDerivation rec {
  name = "picoc-${version}";

  src = fetchFromGitHub {
    sha256 = "01w3jwl0vn9fsmh7p20ad4nl9ljzgfn576yvncd9pk9frx3pd8y4";
    rev = "4555e8456f020554bcac50751fbb9b36c7d8c13b";
    repo = "picoc";
    owner = "zsaleeba";
  };

  meta = with stdenv.lib; {
    inherit version;
    description = "Very small C interpreter for scripting";
    longDescription = ''
      PicoC is a very small C interpreter for scripting. It was originally
      written as a script language for a UAV's on-board flight system. It's
      also very suitable for other robotic, embedded and non-embedded
      applications. The core C source code is around 3500 lines of code. It's
      not intended to be a complete implementation of ISO C but it has all the
      essentials. When compiled it only takes a few k of code space and is also
      very sparing of data space. This means it can work well in small embedded
      devices.
    '';
    homepage = https://github.com/zsaleeba/picoc;
    downloadPage = https://code.google.com/p/picoc/downloads/list;
    license = with licenses; bsd3;
    platforms = with platforms; linux;
    maintainers = with maintainers; [ nckx ];
  };

  buildInputs = [ readline ];

  postPatch = ''
    substituteInPlace Makefile --replace '`svnversion -n`' "${version}"
  '';

  enableParallelBuilding = true;

  doCheck = true;
  checkTarget = "test";

  installPhase = ''
    install -Dm755 picoc $out/bin/picoc

    mkdir -p $out/include
    install -m644 *.h $out/include
  '';
}
