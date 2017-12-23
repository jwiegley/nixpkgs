{ fetchFromGitHub, stdenv, autoreconfHook, pkgconfig, gettext, python3
, texinfo, help2man, libyaml, perl
}:

let
  version = "3.4.0";
in stdenv.mkDerivation rec {
  name = "liblouis-${version}";

  src = fetchFromGitHub {
    owner = "liblouis";
    repo = "liblouis";
    rev = "v${version}";
    sha256 = "1b3vf6sq2iffdvj0r2q5g5k198camy3sq2nwfz391brpwivsnayh";
  };

  outputs = [ "out" "dev" "man" "info" "doc" ];

  nativeBuildInputs = [
    autoreconfHook pkgconfig gettext python3
    # Docs, man, info
    texinfo help2man
  ];

  buildInputs = [
    # lou_checkYaml
    libyaml
    # maketable.d
    perl
  ];

  configureFlags = [
    # Required by Python bindings
    "--enable-ucs4"
  ];

  postPatch = ''
    patchShebangs tests
    substituteInPlace python/louis/__init__.py.in --replace "###LIBLOUIS_SONAME###" "$out/lib/liblouis.so"
  '';

  postInstall = ''
    pushd python
    python setup.py install --prefix="$out" --optimize=1
    popd
  '';

  doCheck = true;

  meta = with stdenv.lib; {
    description = "Open-source braille translator and back-translator";
    homepage = http://liblouis.org/;
    license = licenses.lgpl21;
    maintainers = with maintainers; [ jtojnar ];
    platforms = platforms.unix;
  };
}
