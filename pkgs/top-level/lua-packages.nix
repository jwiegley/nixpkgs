/* This file defines the composition for Lua packages.  It has
   been factored out of all-packages.nix because there are many of
   them.  Also, because most Nix expressions for Lua packages are
   trivial, most are actually defined here.  I.e. there's no function
   for each package in a separate file: the call to the function would
   be almost as must code as the function itself. */

{ fetchurl, fetchzip, stdenv, lua, callPackage, unzip, zziplib, pkgconfig, libtool
, pcre, oniguruma, gnulib, tre, glibc, sqlite, openssl, expat, cairo
, perl, gtk2, python, glib, gobjectIntrospection, libevent, zlib, autoreconfHook
, mysql, postgresql, cyrus_sasl
, fetchFromGitHub, libmpack, which
, pkgs
, recurseIntoAttrs
, fetchgit
, overrides ? (self: super: {})
}:

let
  isLua51 = lua.luaversion == "5.1";
  isLua52 = lua.luaversion == "5.2";
  isLuaJIT = (builtins.parseDrvName lua.name).name == "luajit";

  # Check whether a derivation provides a lua module.
  hasLuaModule = drv: drv? luaModule ;

  # TODO test
  # callPackage = pkgs.newScope self;

  requiredLuaModules = drvs: with stdenv.lib; let
    modules =  filter hasLuaModule drvs;
  in unique ([lua] ++ modules ++ concatLists (catAttrs "requiredLuaModules" modules));

  # Convert derivation to a lua module.
  toLuaModule = drv:
    drv.overrideAttrs( oldAttrs: {
      # Use passthru in order to prevent rebuilds when possible.
      passthru = (oldAttrs.passthru or {})// {
        luaModule = lua;
        requiredLuaModules = requiredLuaModules drv.propagatedBuildInputs;
      };
    });


  platformString =
    if stdenv.isDarwin then "macosx"
    else if stdenv.isFreeBSD then "freebsd"
    else if stdenv.isLinux then "linux"
    else if stdenv.isSunOS then "solaris"
    else throw "unsupported platform";


    generatedPackages = callPackage ./lua-generated-packages.nix {
      inherit self stdenv fetchurl toLuaModule requiredLuaModules;
    };

    self = _self;


  /* list of packages
   *
   */
  _self = with self; generatedPackages //  rec {
    inherit lua;
    inherit requiredLuaModules;
    inherit toLuaModule;
    inherit generatedPackages;
    inherit (stdenv.lib) maintainers;

  wrapLua = callPackage ../development/interpreters/lua-5/wrap-lua.nix {
    inherit lua; inherit (pkgs) makeSetupHook makeWrapper;
  };

  #define build lua package function
  buildLuaPackage = with pkgs.lib; makeOverridable( callPackage ../development/interpreters/lua-5/build-lua-package.nix {
    inherit lua;
    inherit wrapLua;
    inherit toLuaModule;
  });

  buildLuaApplication = args: buildLuaPackage ({namePrefix="";} // args );

  luarocks = callPackage ../development/tools/misc/luarocks {
    inherit lua;
    inherit toLuaModule;
  };

  luarocks-nix = luarocks.overrideAttrs(old: {
    src = fetchFromGitHub {
      owner="teto";
      repo="luarocks";
      rev="a0a90e19d6989981a6a58c2faaf2bbcfb90e3b00";
      sha256 = "0vpji9a7ab6g3k30hqc4pz8yr51zn455pyfppq9ywqkllmjq0ypw";
    };
    # src=/home/teto/luarocks;
    propagatedBuildInputs=old.propagatedBuildInputs ++ [  ];
  });

  cjson = callPackage ../development/lua-modules/cjson {
    inherit lua;
    inherit buildLuaPackage;
  };

  luabitop = buildLuaPackage rec {
    version = "1.0.2";
    pname = "bitop";

    src = fetchurl {
      url = "https://luarocks.org/manifests/luarocks/luabitop-1.0.2-1.src.rock";
      sha256 = "0vpji9a7ab6g3k30hqc4pz8yr51zn455pyfppq9ywqkllmjq0ypw";
    };

    buildFlags = stdenv.lib.optionalString stdenv.isDarwin "macosx";

    postPatch = stdenv.lib.optionalString stdenv.isDarwin ''
      substituteInPlace Makefile --replace 10.4 10.5
    '';

    meta = with stdenv.lib; {
      description = "C extension module for Lua which adds bitwise operations on numbers";
      homepage = "http://bitop.luajit.org";
      license = licenses.mit;
      maintainers = with maintainers; [ ];
    };
  };

  luacheck = buildLuaPackage rec {
    pname = "luacheck";
    version = "0.20.0";
    name = "${pname}-${version}";

    src = fetchFromGitHub {
      owner = "mpeterv";
      repo = "luacheck";
      rev = "${version}";
      sha256 = "0ahfkmqcjhlb7r99bswy1sly6d7p4pyw5f4x4fxnxzjhbq0c5qcs";
    };

    propagatedBuildInputs = [ lua ];

    # No Makefile.
    dontBuild = true;

    installPhase = ''
      ${lua}/bin/lua install.lua $out
    '';

    meta = with stdenv.lib; {
      description = "A tool for linting and static analysis of Lua code";
      homepage = https://github.com/mpeterv/luacheck;
      license = licenses.mit;
      maintainers = with maintainers; [ vyp ];
      platforms = platforms.unix;
    };
  };

  luacyrussasl = buildLuaPackage rec {
    version = "1.1.0";
    name = "lua-cyrussasl-${version}";
    src = fetchFromGitHub {
      owner = "JorjBauer";
      repo = "lua-cyrussasl";
      rev = "v${version}";
      sha256 = "14kzm3vk96k2i1m9f5zvpvq4pnzaf7s91h5g4h4x2bq1mynzw2s1";
    };

    preBuild = ''
      makeFlagsArray=(
        CFLAGS="-O2 -fPIC"
        LDFLAGS="-O -shared -fpic -lsasl2"
        LUAPATH="$out/share/lua/${lua.luaversion}"
        CPATH="$out/lib/lua/${lua.luaversion}"
      );
      mkdir -p $out/{share,lib}/lua/${lua.luaversion}
    '';

    buildInputs = [ cyrus_sasl ];

    meta = with stdenv.lib; {
      homepage = "https://github.com/JorjBauer/lua-cyrussasl";
      description = "Cyrus SASL library for Lua 5.1+";
      license = licenses.bsd3;
    };
  };

  luaevent = buildLuaPackage rec {
    version = "0.4.3";
    name = "luaevent-${version}";
    disabled = isLua52;

    src = fetchFromGitHub {
      owner = "harningt";
      repo = "luaevent";
      rev = "v${version}";
      sha256 = "1c1n2zqx5rwfwkqaq1jj8gvx1vswvbihj2sy445w28icz1xfhpik";
    };

    preBuild = ''
      makeFlagsArray=(
        INSTALL_DIR_LUA="$out/share/lua/${lua.luaversion}"
        INSTALL_DIR_BIN="$out/lib/lua/${lua.luaversion}"
        LUA_INC_DIR="${lua}/include"
      );
    '';

    buildInputs = [ libevent ];

    propagatedBuildInputs = [ luasocket ];

    meta = with stdenv.lib; {
      homepage = http://luaforge.net/projects/luaevent/;
      description = "Binding of libevent to Lua";
      license = licenses.mit;
      maintainers = with maintainers; [ koral ];
    };
  };

  luaexpat = buildLuaPackage rec {
    version = "1.3.0";
    name = "expat-${version}";

    src = fetchurl {
      url = "https://matthewwild.co.uk/projects/luaexpat/luaexpat-${version}.tar.gz";
      sha256 = "1hvxqngn0wf5642i5p3vcyhg3pmp102k63s9ry4jqyyqc1wkjq6h";
    };

    buildInputs = [ expat ];

    preConfigure = stdenv.lib.optionalString stdenv.isDarwin ''
      substituteInPlace Makefile \
      --replace '-shared' '-bundle -undefined dynamic_lookup -all_load'
    '';

    preBuild = ''
      makeFlagsArray=(
        LUA_LDIR="$out/share/lua/${lua.luaversion}"
        LUA_INC="-I${lua}/include" LUA_CDIR="$out/lib/lua/${lua.luaversion}"
        EXPAT_INC="-I${expat.dev}/include");
    '';

    disabled = isLuaJIT;

    meta = with stdenv.lib; {
      description = "SAX XML parser based on the Expat library";
      homepage = "http://matthewwild.co.uk/projects/luaexpat";
      license = licenses.mit;
      maintainers = with maintainers; [ flosse ];
      platforms = platforms.unix;
    };
  };

  luadbi = buildLuaPackage rec {
    name = "luadbi-${version}";
    version = "0.5";
    src = fetchurl {
      url = "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/luadbi/luadbi.${version}.tar.gz";
      sha256 = "07ikxgxgfpimnwf7zrqwcwma83ss3wm2nzjxpwv2a1c0vmc684a9";
    };
    sourceRoot = ".";

    buildInputs = [ mysql.connector-c postgresql sqlite ];

    preConfigure = ''
      substituteInPlace Makefile --replace CC=gcc CC=cc
    '' + stdenv.lib.optionalString stdenv.isDarwin ''
      substituteInPlace Makefile \
        --replace '-shared' '-bundle -undefined dynamic_lookup -all_load'
    '';

    NIX_CFLAGS_COMPILE = [
      "-I${mysql.connector-c}/include/mysql"
      "-L${mysql.connector-c}/lib/mysql"
      "-I${postgresql}/include/server"
    ];

    installPhase = ''
      mkdir -p $out/lib/lua/${lua.luaversion}
      install -p DBI.lua *.so $out/lib/lua/${lua.luaversion}
    '';

    meta = with stdenv.lib; {
      homepage = "https://code.google.com/archive/p/luadbi/";
      platforms = stdenv.lib.platforms.unix;
    };
  };

  luaposix = buildLuaPackage rec {
    name = "posix-${version}";
    version = "33.4.0";

    src = fetchFromGitHub {
      owner = "luaposix";
      repo = "luaposix";
      rev = "release-v${version}";
      sha256 = "0y531p54lx2yf243bcsyp6sv8fvbqidp20yry0xvb85p8zw9dlrq";
    };

    buildInputs = [ perl ];

    meta = with stdenv.lib; {
      description = "Lua bindings for POSIX API";
      homepage = "https://github.com/luaposix/luaposix";
      license = licenses.mit;
      maintainers = with maintainers; [ vyp ];
      platforms = platforms.unix;
    };
  };

  lpty = buildLuaPackage rec {
    version = "1.2.1";
    name = "lpty-${version}";

    src = fetchurl {
      url = "http://www.tset.de/downloads/lpty-${version}-1.tar.gz";
      sha256 = "0rgvbpymcgdkzdwfag607xfscs9xyqxg0dj0qr5fv906mi183gs6";
    };

    preBuild = ''
      makeFlagsArray=(
        INST_LIBDIR="$out/lib/lua/${lua.luaversion}"
        INST_LUADIR="$out/share/lua/${lua.luaversion}"
        LUA_BINDIR="${lua}/bin"
        LUA_INCDIR="-I${lua}/include"
        LUA_LIBDIR="-L${lua}/lib"
        );
    '';

    meta = with stdenv.lib; {
      description = "PTY control for Lua";
      homepage = "http://www.tset.de/lpty";
      license = licenses.mit;
      maintainers = with maintainers; [ vyp ];
      platforms = platforms.linux;
    };
  };

  lua-iconv = buildLuaPackage rec {
    name = "lua-iconv-${version}";
    version = "7";

    src = fetchFromGitHub {
      owner = "ittner";
      repo = "lua-iconv";
      rev = name;
      sha256 = "0rd76966qlxfp8ypkyrbif76nxnm1acclqwfs45wz3972jsk654i";
    };

    preBuild = ''
      makeFlagsArray=(
        INSTALL_PATH="$out/lib/lua/${lua.luaversion}"
      );
    '';

    meta = with stdenv.lib; {
      description = "Lua bindings for POSIX iconv";
      homepage = "https://ittner.github.io/lua-iconv/";
      license = licenses.mit;
      maintainers = with maintainers; [ richardipsum ];
      platforms = platforms.unix;
    };
  };

  luasec = buildLuaPackage rec {
    name = "sec-0.6";

    src = fetchFromGitHub {
      owner = "brunoos";
      repo = "luasec";
      rev = "lua${name}";
      sha256 = "0wv8l7f7na7kw5xn8mjik2wpxbizl7zvvp5s7fcwvz9kl5jdpk5b";
    };

    buildInputs = [ openssl ];

    preBuild = ''
      makeFlagsArray=(
        ${platformString}
        LUAPATH="$out/lib/lua/${lua.luaversion}"
        LUACPATH="$out/lib/lua/${lua.luaversion}"
        INC_PATH="-I${lua}/include"
        LIB_PATH="-L$out/lib");
    '';

    meta = with stdenv.lib; {
      description = "Lua binding for OpenSSL library to provide TLS/SSL communication";
      homepage = "https://github.com/brunoos/luasec";
      license = licenses.mit;
      maintainers = with maintainers; [ flosse ];
      platforms = platforms.unix;
    };
  };

  luasocket = buildLuaPackage rec {
    name = "socket-${version}";
    version = "3.0-rc1";

    src = fetchFromGitHub {
      owner = "diegonehab";
      repo = "luasocket";
      rev = "v${version}";
      sha256 = "1chs7z7a3i3lck4x7rz60ziwbf793gw169hpjdfca8y4yf1hzsxk";
    };

    patchPhase = stdenv.lib.optionalString stdenv.isDarwin ''
      substituteInPlace src/makefile --replace gcc cc \
        --replace 10.3 10.5
    '';

    preBuild = ''
      makeFlagsArray=(
        LUAV=${lua.luaversion}
        PLAT=${platformString}
        prefix=$out
      );
    '';

    installTargets = [ "install" "install-unix" ];

    meta = with stdenv.lib; {
      description = "Network support for Lua";
      homepage = "http://w3.impa.br/~diego/software/luasocket/";
      license = licenses.mit;
      maintainers = with maintainers; [ ];
      platforms = with platforms; darwin ++ linux ++ freebsd ++ illumos;
    };
  };

  luxio = buildLuaPackage rec {
    name = "luxio-${version}";
    version = "13";

    src = fetchurl {
      url = "https://git.gitano.org.uk/luxio.git/snapshot/luxio-luxio-13.tar.bz2";
      sha256 = "1hvwslc25q7k82rxk461zr1a2041nxg7sn3sw3w0y5jxf0giz2pz";
    };

    nativeBuildInputs = [ which pkgconfig ];

    postPatch = ''
      patchShebangs .
    '';

    preBuild = ''
      makeFlagsArray=(
        INST_LIBDIR="$out/lib/lua/${lua.luaversion}"
        INST_LUADIR="$out/share/lua/${lua.luaversion}"
        LUA_BINDIR="$out/bin"
        INSTALL=install
        );
    '';

    meta = with stdenv.lib; {
      description = "Lightweight UNIX I/O and POSIX binding for Lua";
      homepage = "https://www.gitano.org.uk/luxio/";
      license = licenses.mit;
      maintainers = with maintainers; [ richardipsum ];
      platforms = platforms.unix;
    };
  };

  luazip = buildLuaPackage rec {
    name = "zip-${version}";
    version = "2007-10-30";

    src = fetchFromGitHub {
      owner = "luaforge";
      repo = "luazip";
      rev = "0b8f5c958e170b1b49f05bc267bc0351ad4dfc44";
      sha256 = "0zrrwhmzny5zbpx91bjbl77gzkvvdi3qhhviliggp0aj8w3faxsr";
    };

    buildInputs = [ zziplib ];

    patches = [ ../development/lua-modules/zip.patch ];

    # Does not currently work under Lua 5.2 or LuaJIT.
    disabled = isLua52 || isLuaJIT;

    meta = with stdenv.lib; {
      description = "Lua library to read files stored inside zip files";
      homepage = "https://github.com/luaforge/luazip";
      license = licenses.mit;
      maintainers = with maintainers; [ vyp ];
      platforms = platforms.linux;
    };
  };

  luazlib = buildLuaPackage rec {
    name = "zlib-${version}";
    version = "1.1";

    src = fetchFromGitHub {
      owner = "brimworks";
      repo = "lua-zlib";
      rev = "v${version}";
      sha256 = "1520lk4xpf094xn2zallqgqhs0zb4w61l49knv9y8pmhkdkxzzgy";
    };

    buildInputs = [ zlib ];

    preConfigure = ''
      substituteInPlace Makefile --replace gcc cc --replace "-llua" ""
    '';

    preBuild = ''
      makeFlagsArray=(
        ${platformString}
        LUAPATH="$out/share/lua/${lua.luaversion}"
        LUACPATH="$out/lib/lua/${lua.luaversion}"
        INCDIR="-I${lua}/include"
        LIBDIR="-L${lua}/lib");
    '';

    preInstall = "mkdir -p $out/lib/lua/${lua.luaversion}";

    meta = with stdenv.lib; {
      description = "Simple streaming interface to zlib for Lua";
      homepage = https://github.com/brimworks/lua-zlib;
      license = licenses.mit;
      maintainers = with maintainers; [ koral ];
      platforms = platforms.unix;
    };
  };


  luastdlib = buildLuaPackage rec {
    name = "stdlib-${version}";
    version = "41.2.1";

    src = fetchFromGitHub {
      owner = "lua-stdlib";
      repo = "lua-stdlib";
      rev = "release-v${version}";
      sha256 = "03wd1qvkrj50fjszb2apzdkc8d5bpfbbi9pajl0vbrlzzmmi3jlq";
    };

    nativeBuildInputs = [ autoreconfHook unzip ];

    meta = with stdenv.lib; {
      description = "General Lua libraries";
      homepage = "https://github.com/lua-stdlib/lua-stdlib";
      license = licenses.mit;
      maintainers = with maintainers; [ vyp ];
      platforms = platforms.linux;
    };
  };

  lrexlib = buildLuaPackage rec {
    name = "lrexlib-${version}";
    version = "2.8.0";

    src = fetchFromGitHub {
      owner = "rrthomas";
      repo = "lrexlib";
      rev = "rel-2-8-0";
      sha256 = "1c62ny41b1ih6iddw5qn81gr6dqwfffzdp7q6m8x09zzcdz78zhr";
    };

    buildInputs = [ luastdlib pcre luarocks oniguruma gnulib tre glibc ];

    buildPhase = let
      luaVariable = ''LUA_PATH="${luastdlib}/share/lua/${lua.luaversion}/?/init.lua;${luastdlib}/share/lua/${lua.luaversion}/?.lua"'';
      pcreVariable = "PCRE_DIR=${pcre.out} PCRE_INCDIR=${pcre.dev}/include";
      onigVariable = "ONIG_DIR=${oniguruma}";
      gnuVariable = "GNU_INCDIR=${gnulib}/lib";
      treVariable = "TRE_DIR=${tre}";
      posixVariable = "POSIX_DIR=${glibc.dev}";
    in ''
      sed -e 's@$(LUAROCKS) $(LUAROCKS_COMMAND) $$i;@$(LUAROCKS) $(LUAROCKS_COMMAND) $$i ${pcreVariable} ${onigVariable} ${gnuVariable} ${treVariable} ${posixVariable};@' -i Makefile
      ${luaVariable} make
    '';

    installPhase = ''
      mkdir -pv $out;
      cp -r luarocks/lib $out;
    '';

    meta = with stdenv.lib; {
      description = "Lua bindings of various regex library APIs";
      homepage = "https://github.com/rrthomas/lrexlib";
      license = licenses.mit;
      maintainers = with maintainers; [ vyp ];
      platforms = platforms.linux;
    };
  };

  luasqlite3 = buildLuaPackage rec {
    name = "sqlite3-${version}";
    version = "2.3.0";

    src = fetchFromGitHub {
      owner = "LuaDist";
      repo = "luasql-sqlite3";
      rev = version;
      sha256 = "05k8zs8nsdmlwja3hdhckwknf7ww5cvbp3sxhk2xd1i3ij6aa10b";
    };

    buildInputs = [ sqlite ];

    patches = [ ../development/lua-modules/luasql.patch ];

    meta = with stdenv.lib; {
      description = "Database connectivity for Lua";
      homepage = "https://github.com/LuaDist/luasql-sqlite3";
      license = licenses.mit;
      maintainers = with maintainers; [ vyp ];
      platforms = platforms.linux;
    };
  };

  lpeg = buildLuaPackage rec {
    pname = "lpeg";
    version = "0.12";



    src = fetchurl {
      url="https://luarocks.org/manifests/gvvaughan/lpeg-1.0.1-1.src.rock";
      sha256= "17ganb7sd4cd6l1zy00dr9717pcqngcn8wpafx7nki2m04gf76ql";
    };
    buildInputs = [ unzip ];

    meta = with stdenv.lib; {
      description = "Parsing Expression Grammars For Lua";
      homepage = "http://www.inf.puc-rio.br/~roberto/lpeg/";
      license = licenses.mit;
      maintainers = with maintainers; [ vyp ];
      platforms = platforms.all;
    };
  };


  lgi = stdenv.mkDerivation rec {
    name = "lgi-${version}";
    version = "0.9.1";

    src = fetchFromGitHub {
      owner = "pavouk";
      repo = "lgi";
      rev = version;
      sha256 = "09pbapjhyc3sn0jgx747shqr9286wqfzw02h43p4pk8fv2b766b9";
    };

    nativeBuildInputs = [ pkgconfig ];
    buildInputs = [ glib gobjectIntrospection lua ];

    makeFlags = [ "LUA_VERSION=${lua.luaversion}" ];

    preBuild = ''
      sed -i "s|/usr/local|$out|" lgi/Makefile
    '';

    meta = with stdenv.lib; {
      description = "GObject-introspection based dynamic Lua binding to GObject based libraries";
      homepage    = https://github.com/pavouk/lgi;
      license     = licenses.mit;
      maintainers = with maintainers; [ lovek323 rasendubi ];
      platforms   = platforms.unix;
    };
  };

coxpcall = buildLuaPackage rec {
src= fetchurl {

# url=http://luarocks.org/manifests/teto/coxpcall-scm-1.src.rock;
# sha256="0cz1m32kxi5zx6s69vxdldaafmzqj5wwr69i93abmlz15nx2bqpf";

url=https://luarocks.org/manifests/hisham/coxpcall-1.15.0-1.src.rock;
sha256="0x8hzly5vjmj8xbhg6l2hxhj57ysgrz7afb7wss4pmkc187d74zz";
}
;
version="1.15.0-1";
pname="coxpcall";
propagatedBuildInputs=[];
meta={
license=stdenv.lib.licenses.mit;
description="Coroutine safe xpcall and pcall";
homepage=http://keplerproject.github.io/coxpcall; }
; }
;

  vicious = stdenv.mkDerivation rec {
    name = "vicious-${version}";
    version = "2.3.1";

    src = fetchFromGitHub {
      owner = "Mic92";
      repo = "vicious";
      rev = "v${version}";
      sha256 = "1yzhjn8rsvjjsfycdc993ms6jy2j5jh7x3r2ax6g02z5n0anvnbx";
    };

    buildInputs = [ lua ];

    installPhase = ''
      mkdir -p $out/lib/lua/${lua.luaversion}/
      cp -r . $out/lib/lua/${lua.luaversion}/vicious/
      printf "package.path = '$out/lib/lua/${lua.luaversion}/?/init.lua;' ..  package.path\nreturn require((...) .. '.init')\n" > $out/lib/lua/${lua.luaversion}/vicious.lua
    '';

    meta = with stdenv.lib; {
      description = "A modular widget library for the awesome window manager";
      homepage    = https://github.com/Mic92/vicious;
      license     = licenses.gpl2;
      maintainers = with maintainers; [ makefu mic92 ];
      platforms   = platforms.linux;
    };
  };

}; in self
