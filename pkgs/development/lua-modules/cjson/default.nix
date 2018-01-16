{ lua,
stdenv,
buildLuaPackage,
fetchurl
}:
buildLuaPackage rec {
    name = "cjson-${version}";
    version = "2.1.0";
    src = fetchurl {
      url = "http://www.kyne.com.au/~mark/software/download/lua-cjson-2.1.0.tar.gz";
      sha256 = "0y67yqlsivbhshg8ma535llz90r4zag9xqza5jx0q7lkap6nkg2i";
    };

    preBuild = ''
      cd ..
      ls
      sed -i "s|/usr/local|$out|" Makefile
    '';
    makeFlags = [ "VERBOSE=1" "LUA_VERSION=${lua.luaversion}" ];
    postInstall = ''
      rm -rf $out/share/lua/${lua.luaversion}/cjson/tests
    '';


    installTargets = "install install-extra";

    meta = {
      description = "Lua C extension module for JSON support";
      license = stdenv.lib.licenses.mit;
    };
  }

