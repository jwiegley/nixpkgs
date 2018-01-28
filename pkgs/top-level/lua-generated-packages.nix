/*  is an auto-generated file -- DO NOT EDIT!
Regenerate it with:
nixpkgs$ maintainers/scripts/update-luarocks-packages.sh
*/
{
# self has buildLuaPackage
self
, stdenv
, fetchurl
, fetchgit
, toLuaModule
, requiredLuaModules
}:
with self;
rec {
ansicolors = buildLuaPackage rec {
  pname = "ansicolors";
  version = "1.0.2-3";
  src = fetchurl {
    url    = https://luarocks.org/ansicolors-1.0.2-3.src.rock;
    sha256 = "1mhmr090y5394x1j8p44ws17sdwixn5a0r4i052bkfgk3982cqfz";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = https://github.com/kikito/ansicolors.lua;
    description="Library for color Manipulation.";
    license = {
      fullName = "MIT <http://opensource.org/licenses/MIT>";
    };
    buildType="builtin";
  };
};

dkjson = buildLuaPackage rec {
  pname = "dkjson";
  version = "2.5-2";
  src = fetchurl {
    url    = https://luarocks.org/dkjson-2.5-2.src.rock;
    sha256 = "1qy9bzqnb9pf9d48hik4iq8h68aw3270kmax7mmpvvpw7kkyp483";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = http://dkolf.de/src/dkjson-lua.fsl/;
    description="David Kolf's JSON module for Lua";
    license = {
      fullName = "MIT/X11";
    };
    buildType="builtin";
  };
};

lua-cmsgpack = buildLuaPackage rec {
  pname = "lua-cmsgpack";
  version = "0.3-2";
  src = fetchurl {
    url    = https://luarocks.org/lua-cmsgpack-0.3-2.src.rock;
    sha256 = "062nk6y99d24qhahwp9ss4q2xhrx40djpl4vgbpmjs8wv0ds84di";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = http://github.com/antirez/lua-cmsgpack;
    description="MessagePack C implementation and bindings for Lua 5.1";
    license = {
      fullName = "Two-clause BSD";
    };
    buildType="builtin";
  };
};

lua_cliargs = buildLuaPackage rec {
  pname = "lua_cliargs";
  version = "3.0-1";
  src = fetchurl {
    url    = https://luarocks.org/lua_cliargs-3.0-1.src.rock;
    sha256 = "1m17pxirngpm5b1k71rqs8zlwwav1rv52z8d4w8kmj0xn4kvcrfi";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = https://github.com/amireh/lua_cliargs;
    description="A command-line argument parser.";
    license = {
      fullName = "MIT <http://opensource.org/licenses/MIT>";
    };
    buildType="builtin";
  };
};


lua-term = buildLuaPackage rec {
  pname = "lua-term";
  version = "0.3-1";
  src = fetchurl {
    url    = https://luarocks.org/lua-term-0.3-1.src.rock;
    sha256 = "1bxfaskb30hpcaz8jmv5mshp56dgxlc2bm6fgf02z556cdy3kapm";
  };

  propagatedBuildInputs = [];

  meta = {
    homepage = https://github.com/hoelzro/lua-term;
    description="Terminal functions for Lua";
    license = {
      fullName = "MIT/X11";
    };
    buildType="builtin";
  };
};

luasocket = buildLuaPackage rec {
  pname = "luasocket";
  version = "3.0rc1-2";
  src = fetchurl {
    url    = https://luarocks.org/luasocket-3.0rc1-2.src.rock;
    sha256 = "1isin9m40ixpqng6ds47skwa4zxrc6w8blza8gmmq566w6hz50iq";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = http://luaforge.net/projects/luasocket/;
    description="Network support for the Lua language";
    license = {
      fullName = "MIT";
    };
    buildType="builtin";
  };
};

ltermbox = buildLuaPackage rec {
  pname = "ltermbox";
  version = "0.2-1";
  src = fetchurl {
    url    = https://luarocks.org/ltermbox-0.2-1.src.rock;
    sha256 = "08jqlmmskbi1ml1i34dlmg6hxcs60nlm32dahpxhcrgjnfihmyn8";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = http://code.google.com/p/termbox;
    description="A termbox library package";
    license = {
      fullName = "New BSD License";
    };
    buildType="builtin";
  };
};

luafilesystem = buildLuaPackage rec {
  pname = "luafilesystem";
  version = "1.7.0-2";
  src = fetchurl {
    url    = https://luarocks.org/luafilesystem-1.7.0-2.src.rock;
    sha256 = "0xhmd08zklsgpnpjr9rjipah35fbs8jd4v4va36xd8bpwlvx9rk5";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = git://github.com/keplerproject/luafilesystem;
    description="File System Library for the Lua Programming Language";
    license = {
      fullName = "MIT/X11";
    };
    buildType="builtin";
  };
};

penlight = buildLuaPackage rec {
  pname = "penlight";
  version = "1.3.1-1";
  src = fetchurl {
    url    = https://luarocks.org/penlight-1.3.1-1.src.rock;
    sha256 = "10w7yf1n3nrr5ima9aggs9zd7mwiynb29df4vl2qb6ca0p2zrihk";
  };

  propagatedBuildInputs = [luafilesystem ];

  meta = {
    homepage = http://stevedonovan.github.com/Penlight;
    description="Lua utility libraries loosely based on the Python standard libraries";
    license = {
      fullName = "MIT/X11";
    };
    buildType="builtin";
  };
};

say = buildLuaPackage rec {
  pname = "say";
  version = "1.2-1";
  src = fetchurl {
    url    = https://luarocks.org/say-1.2-1.src.rock;
    sha256 = "0x367gyfzdv853ag2bbg5a2hsis4i9ryhb5brxp9gh136in5wjcw";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = http://olivinelabs.com/busted/;
    description="Lua String Hashing/Indexing Library";
    license = {
      fullName = "MIT <http://opensource.org/licenses/MIT>";
    };
    buildType="builtin";
  };
};

luv = buildLuaPackage rec {
  pname = "luv";
  version = "1.9.1-1";
  src = fetchurl {
    url    = https://luarocks.org/luv-1.9.1-1.src.rock;
    sha256 = "1b2gjzk7zixm98ah1xi02k1x2rhl109nqkn1w4jyjfwb3lrbhbfp";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = https://github.com/luvit/luv;
    description="Bare libuv bindings for lua";
    license = {
      fullName = "Apache 2.0";
    };
    buildType="cmake";
  };
};

luasystem = buildLuaPackage rec {
  pname = "luasystem";
  version = "0.2.1-0";
  src = fetchurl {
    url    = https://luarocks.org/luasystem-0.2.1-0.src.rock;
    sha256 = "091xmp8cijgj0yzfsjrn7vljwznjnjn278ay7z9pjwpwiva0diyi";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = http://olivinelabs.com/luasystem/;
    description="Platform independent system calls for Lua.";
    license = {
      fullName = "MIT <http://opensource.org/licenses/MIT>";
    };
    buildType="builtin";
  };
};

mediator_lua = buildLuaPackage rec {
  pname = "mediator_lua";
  version = "1.1.2-0";
  src = fetchurl {
    url    = http://luarocks.org/manifests/teto/mediator_lua-1.1.2-0.src.rock;
    sha256 = "18j49vvs94yfk4fw0xsq4v3j4difr6c99gfba0kxairmcqamd1if";
  };

  propagatedBuildInputs = [lua ];

  meta = {
    homepage = http://olivinelabs.com/mediator_lua/;
    description="Event handling through channels";
    license = {
      fullName = "MIT <http://opensource.org/licenses/MIT>";
    };
    buildType="builtin";
  };
};

mpack = buildLuaPackage rec {
  pname = "mpack";
  version = "1.0.6-0";
  src = fetchurl {
    url    = https://luarocks.org/mpack-1.0.6-0.src.rock;
    sha256 = "0pydlhgdfbchslizm69h5w5ddalhzaq71hlbl5z2miq7yk9xjs4h";
  };

  propagatedBuildInputs = [];

  meta = {
    homepage = https://github.com/libmpack/libmpack-lua/releases/download/1.0.6/libmpack-lua-1.0.6.tar.gz;
    description="Lua binding to libmpack";
    license = {
      fullName = "MIT";
    };
    buildType="builtin";
  };
};

nvim-client = buildLuaPackage rec {
  pname = "nvim-client";
  version = "0.0.1-26";
  src = fetchurl {
    url    = http://luarocks.org/manifests/teto/nvim-client-0.0.1-26.src.rock;
    sha256 = "1k3rrii6w2zjmwaanldsbm8fb2d5xzzfwzwjipikxsabivhrm9hs";
  };

  propagatedBuildInputs = [lua mpack luv coxpcall ];

  meta = {
    homepage = https://github.com/neovim/lua-client/archive/0.0.1-26.tar.gz;
    description="Lua client to Nvim";
    license = {
      fullName = "Apache";
    };
    buildType="builtin";
  };
};

busted = buildLuaPackage rec {
  pname = "busted";
  version = "2.0.rc12-1";
  src = fetchurl {
    url    = http://luarocks.org/manifests/teto/busted-2.0.rc12-1.src.rock;
    sha256 = "18fzdc7ww4nxwinnw9ah5hi329ghrf0h8xrwcy26lk9qcs9n079z";
  };

  propagatedBuildInputs = [lua lua_cliargs luafilesystem luasystem dkjson say luassert lua-term penlight mediator_lua ];

  meta = {
    homepage = http://olivinelabs.com/busted/;
    description="Elegant Lua unit testing.";
    license = {
      fullName = "MIT <http://opensource.org/licenses/MIT>";
    };
    buildType="builtin";
  };
};

luassert = buildLuaPackage rec {
version="1.7.10-0";
pname="luassert";
propagatedBuildInputs=[ lua say];
meta={
homepage=http://olivinelabs.com/busted/;
description="Lua Assertions Extension";
license=stdenv.lib.licenses.mit; }
;
src= fetchurl {
url=http://luarocks.org/manifests/teto/luassert-1.7.10-0.src.rock;
sha256="03kd0zhpl2ir0r45z12bayvwahy8pbbcwk1vfphf0zx11ik84rss"; }
; }
;

}
/* GENERATED */
