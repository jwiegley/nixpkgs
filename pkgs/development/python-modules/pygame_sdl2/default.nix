{
stdenv, lib, pkgs, buildPythonPackage, fetchFromGitHub,
cython, SDL2, SDL2_image, SDL2_ttf, SDL2_mixer, libjpeg, libpng
}:

buildPythonPackage rec {
  pname = "pygame_sdl2";
  version = "6.99.10.1227";
  name = "${pname}-${version}";

  meta = {
    description = "A reimplementation of parts of pygame API using SDL2";
    homepage    = "https://github.com/renpy/pygame_sdl2";
    # Some parts are also available under Zlib License
    license     = lib.licenses.lgpl2;
    maintainers = with lib.maintainers; [ raskin ];
  };

  buildInputs = [
    SDL2 SDL2_image SDL2_ttf SDL2_mixer
    cython libjpeg libpng ];

  postInstall = ''
    ( cd "$out"/include/python*/ ;
      ln -s pygame-sdl2 pygame_sdl2 || true ; )
  '';

  src = fetchFromGitHub {
    owner = "renpy";
    repo = "${pname}";
    rev = "renpy-${version}";
    sha256 = "10n6janvqh5adn7pcijqwqfh234sybjz788kb8ac6b4l11hy2lx1";
  };
}
