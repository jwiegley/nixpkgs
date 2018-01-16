{stdenv, fetchurl, lua, curl, makeWrapper, which, unzip
# for 'luarocks pack'
, zip
# some packages need to be compiled with cmake
, cmake
}:
let
  s = # Generated upstream information
  rec {
    baseName="luarocks";
    version="2.4.3";
    name="${baseName}-${version}";
    hash="0binkd8mpzdzvx0jw0dwm4kr1p7jny015zykf8f15fymzqr4shad";
    url="http://luarocks.org/releases/luarocks-2.4.3.tar.gz";
    sha256="0binkd8mpzdzvx0jw0dwm4kr1p7jny015zykf8f15fymzqr4shad";
  };
  buildInputs = [
    lua curl makeWrapper which unzip
  ];
in
stdenv.mkDerivation {
  inherit (s) name version;
  inherit buildInputs;
  src = fetchurl {
    inherit (s) url sha256;
  };
  preConfigure = ''
    lua -e "" || {
        luajit -e "" && {
	    export LUA_SUFFIX=jit
	    configureFlags="$configureFlags --lua-suffix=$LUA_SUFFIX"
	}
    }
    lua_inc="$(echo "${lua}/include"/*/)"
    if test -n "$lua_inc"; then
        configureFlags="$configureFlags --with-lua-include=$lua_inc"
    fi
  '';
  postInstall = ''
    sed -e "1s@.*@#! ${lua}/bin/lua$LUA_SUFFIX@" -i "$out"/bin/*
    for i in "$out"/bin/*; do
        test -L "$i" || {
	    wrapProgram "$i" \
	      --prefix LUA_PATH ";" "$(echo "$out"/share/lua/*/)?.lua" \
	      --prefix LUA_PATH ";" "$(echo "$out"/share/lua/*/)?/init.lua" \

	}
    done
  '';

  propagatedBuildInputs = [ zip unzip cmake ];

  # unpack hook
  setupHook = ./setup-hook.sh;

  # cmake is just to compile packages wit cmake types, not luarocks itself
  dontUseCmakeConfigure = true;

  meta = with stdenv.lib; {
    inherit (s) version;
    description = ''A package manager for Lua'';
    license = licenses.mit ;
    maintainers = [maintainers.raskin];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
