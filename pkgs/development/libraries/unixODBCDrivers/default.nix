args : with args;
# each attr contains the name deriv referencing the derivation and ini which
# evaluates to a string which can be appended to the global unix odbc ini file
# to register the driver
# I haven't done any parameter tweaking.. So the defaults provided here might be bad
{
# new postgres connector library (doesn't work yet)
  psqlng = rec {
    deriv = stdenv.mkDerivation {
      name = "unix-odbc-pg-odbcng-0.90.101";
      buildInputs = [ unixODBC glibc libtool postgresql ];
      # added -ltdl to resolve missing references `dlsym' `dlerror' `dlopen' `dlclose' 
      preConfigure="
        export CPPFLAGS=-I${unixODBC}/include
        export LDFLAGS='-L${unixODBC}/lib -lltdl'
      ";
      src = fetchurl {
        # using my mirror because original url is https
        # https://projects.commandprompt.com/public/odbcng/attachment/wiki/Downloads/odbcng-0.90.101.tar.gz";
        url = http://mawercer.de/~publicrepos/odbcng-0.90.101.tar.gz;
        sha256 = "13z3sify4z2jcil379704w0knkpflg6di4jh6zx1x2gdgzydxa1y";
      };
      meta = {
          description = "unix odbc driver for postgresql";
          homepage = https://projects.commandprompt.com/public/odbcng;
          license = "GPL2";
      };
    };
    ini = "";
  };
# official postgres connector
 psql = rec {
   deriv = stdenv.mkDerivation {
    name = "psql-odbc-08.03.0200";
    buildInputs = [ unixODBC libtool postgresql openssl ];
    preConfigure="
      export CPPFLAGS=-I${unixODBC}/include
      export LDFLAGS='-L${unixODBC}/lib -lltdl'
    ";
    # added -ltdl to resolve missing references `dlsym' `dlerror' `dlopen' `dlclose' 
    src = fetchurl {
      url = http://wwwmaster.postgresql.org/redir?setmir=53&typ=h&url=http://ftp.de.postgresql.org/mirror/postgresql//odbc/versions/src/psqlodbc-08.03.0200.tar.gz;
      name = "psqlodbc-08.03.0200.tar.gz";
      sha256 = "1401hgzvs3m2yr2nbbf9gfy2wwijrk4ihwz972arbn0krsiwxya1";
    };
    meta = {
        description = "unix odbc driver for postgresql";
        homepage =  http://pgfoundry.org/projects/psqlodbc/;
        license = "LGPL";
    };
  };
  ini = 
    "[PostgreSQL]\n" +
    "Description     = official PostgreSQL driver for Linux & Win32\n" +
    "Driver          = ${deriv}/lib/psqlodbcw.so\n" +
    "Threading       = 2\n";
 };
# mysql connector
 mysql = rec {
    libraries = ["lib/libmyodbc3-3.51.12.so"];
    deriv = stdenv.mkDerivation {
      name = "mysql-connector-odbc-3.51.12";
      src = fetchurl {
        url = http://ftp.snt.utwente.nl/pub/software/mysql/Downloads/MyODBC3/mysql-connector-odbc-3.51.12.tar.gz;
        md5 = "a484f590464fb823a8f821b2f1fd7fef";
      };
      configureFlags = "--disable-gui"
         +  " --with-mysql-path=${mysql} --with-unixODBC=${unixODBC}";
      buildInputs = [libtool zlib];
      inherit mysql unixODBC;
    };
    ini =
      "[MYSQL]\n" +
      "Description     = MySQL driver\n" +
      "Driver          = ${deriv}/lib/libmyodbc3-3.51.12.so\n" +
      "CPTimeout       = \n" +
      "CPReuse         = \n" +
      "FileUsage       = 3\n ";
 };
 sqlite = rec {
    deriv = (import ../sqliteodbc { inherit stdenv fetchurl unixODBC sqlite; });
    ini = ''
      [SQLite]
      Description     = SQLite ODBC Driver
      Driver          = ${deriv}/lib/libsqlite3odbc.so
      Setup           = ${deriv}/lib/libsqlite3odbc.so
      Threading       = 2
    '';
 };
}
