{ stdenv, fetchFromGitHub, cmake, pkgconfig, gcc, glibc
, bison2, curl, flex, gperftools, jansson, jemalloc, kerberos, lua, mariadb
, ncurses, openssl, pcre, pcre2, perl, rabbitmq-c, sqlite, tcl
, libaio, libedit, libtool, libui, libuuid, zlib
}:

stdenv.mkDerivation rec {
  name = "maxscale-${version}";
  version = "2.1.13";

  src = fetchFromGitHub {
    owner = "mariadb-corporation";
    repo = "MaxScale";
    rev = "${name}";
    sha256 = "0bwm98mbjay24vf95rk4slvjqxqblx14hvv75dpp1lhfhw25hhrf";
  };

  nativeBuildInputs = [ cmake pkgconfig ];

  buildInputs = [
    bison2 curl flex gperftools jansson jemalloc kerberos lua mariadb.connector-c
    ncurses openssl pcre pcre2 perl rabbitmq-c sqlite tcl
    libaio libedit libtool libui libuuid zlib
  ];

  patches = [ ./getopt.patch ];

  preConfigure = ''
    for i in `grep -l -R '#include <getopt.h>' .`; do
      substituteInPlace $i --replace "#include <getopt.h>" "#include <${glibc.dev}/include/getopt.h>"
    done
 '';

  cmakeFlags = [
    "-DUSE_C99=YES"
    "-DDEFAULT_ADMIN_USER=root"
    "-DWITH_MAXSCALE_CNF=YES"
    "-DSTATIC_EMBEDDED=YES"
    "-DBUILD_RABBITMQ=YES"
    "-DBUILD_BINLOG=YES"
    "-DBUILD_CDC=NO"
    "-DBUILD_MMMON=YES"
    "-DBUILD_LUAFILTER=YES"
    "-DLUA_LIBRARIES=${lua}/lib"
    "-DLUA_INCLUDE_DIR=${lua}/include"
    "-DGCOV=NO"
    "-DWITH_SCRIPTS=OFF"
    "-DBUILD_TESTS=NO"
    "-DBUILD_TOOLS=NO"
    "-DPROFILE=NO"
    "-DWITH_TCMALLOC=YES"
    "-DWITH_JEMALLOC=YES"
    "-DINSTALL_EXPERIMENTAL=YES"
    "-DTARGET_COMPONENT=all"
  ];

  CFLAGS = "-std=gnu99";

  enableParallelBuilding = true;

  postInstall = ''
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jemalloc kerberos openssl pcre2 zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/bin/dbfwchk
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ glibc libedit ncurses ]}:$out/lib/maxscale $out/bin/maxadmin
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jemalloc kerberos libuuid openssl pcre2 zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/bin/maxbinlogcheck
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jemalloc kerberos openssl pcre2 zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/bin/maxkeys
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jemalloc kerberos openssl pcre2 zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/bin/maxpasswd
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jemalloc kerberos openssl pcre2 zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/bin/maxscale
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libauroramon.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libauroramon.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libbinlogrouter.so.2.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libbinlogrouter.so.2.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libcache.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libcache.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libccrfilter.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libccrfilter.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libcli.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libcli.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libdbfwfilter.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libdbfwfilter.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libdebugcli.so.1.1.1 $$ patchelf --shrink-rpath $out/lib/maxscale/libdebugcli.so.1.1.1
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libgaleramon.so.2.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libgaleramon.so.2.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libGSSAPIAuth.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libGSSAPIAuth.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libGSSAPIBackendAuth.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libGSSAPIBackendAuth.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libhintfilter.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libhintfilter.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libHTTPAuth.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libHTTPAuth.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libHTTPD.so.1.0.1 $$ patchelf --shrink-rpath $out/lib/maxscale/libHTTPD.so.1.0.1
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libinsertstream.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libinsertstream.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libluafilter.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libluafilter.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libmasking.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libmasking.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libMaxAdminAuth.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libMaxAdminAuth.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libmaxinfo.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libmaxinfo.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libmaxrows.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libmaxrows.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libmaxscale-common.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/common.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libmaxscaled.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libmaxscaled.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libmmmon.so.1.1.1 $$ patchelf --shrink-rpath $out/lib/maxscale/libmmmon.so.1.1.1
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libmqfilter.so.1.0.2 $$ patchelf --shrink-rpath $out/lib/maxscale/libmqfilter.so.1.0.2
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libMySQLAuth.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libMySQLAuth.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libMySQLBackendAuth.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libMySQLBackendAuth.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libMySQLBackend.so.2.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libMySQLBackend.so.2.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libMySQLClient.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libMySQLClient.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libMySQLCommon.so.2.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libMySQLCommon.so.2.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libmysqlmon.so.1.4.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libmysqlmon.so.1.4.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libnamedserverfilter.so.1.1.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libnamedserverfilter.so.1.1.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libndbclustermon.so.2.1.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libndbclustermon.so.2.1.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libNullAuthAllow.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libNullAuthAllow.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libNullAuthDeny.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libNullAuthDeny.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libnullfilter.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libnullfilter.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libqc_dummy.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libqc_dummy.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libqc_sqlite.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libqc_sqlite.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libqlafilter.so.1.1.1 $$ patchelf --shrink-rpath $out/lib/maxscale/libqlafilter.so.1.1.1
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libreadconnroute.so.1.1.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libreadconnroute.so.1.1.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libreadwritesplit.so.1.0.2 $$ patchelf --shrink-rpath $out/lib/maxscale/libreadwritesplit.so.1.0.2
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libregexfilter.so.1.1.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libregexfilter.so.1.1.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libschemarouter.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libschemarouter.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libstorage_inmemory.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libstorage_inmemory.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libtee.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libtee.so.1.0.0
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libtelnetd.so.1.0.1 $$ patchelf --shrink-rpath $out/lib/maxscale/libtelnetd.so.1.0.1
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libtopfilter.so.1.0.1 $$ patchelf --shrink-rpath $out/lib/maxscale/libtopfilter.so.1.0.1
    patchelf --set-rpath ${stdenv.lib.makeLibraryPath [ curl gcc.cc.lib glibc jansson jemalloc kerberos libedit libuuid lua openssl pcre2 rabbitmq-c sqlite zlib ]}:${mariadb.connector-c}/lib/mariadb:$out/lib/maxscale $out/lib/maxscale/libtpmfilter.so.1.0.0 $$ patchelf --shrink-rpath $out/lib/maxscale/libtpmfilter.so.1.0.0
    mv $out/share/maxscale/create_grants $out/bin
    rm -rf $out/{etc,var}
  '';

  meta = with stdenv.lib; {
     description = ''MaxScale database proxy extends MariaDB Server's high availability'';
     homepage = https://mariadb.com/products/technology/maxscale;
     license = licenses.bsl11;
     platforms = platforms.linux;
     maintainers = with maintainers; [ izorkin ];
 };
}

