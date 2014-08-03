{ stdenv, fetchurl, SDL2 }:

stdenv.mkDerivation rec {
  name = "SDL2_net-2.0.0";

  src = fetchurl {
    url = "http://www.libsdl.org/projects/SDL_net/release/${name}.tar.gz";
    sha256 = "d715be30783cc99e541626da52079e308060b21d4f7b95f0224b1d06c1faacab";
  };

  propagatedBuildInputs = [stdenv SDL2];

  postInstall = "ln -s $out/include/SDL2/SDL_net.h $out/include/";

  meta = {
    description = "SDL multiplatform networking library";
  };
}
