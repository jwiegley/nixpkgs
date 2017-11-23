{ lib
, python
, buildPythonPackage
, fetchPypi
, fetchzip
, alembic
, ipython
, jinja2
, python-oauth2
, pamela
, sqlalchemy
, tornado
, traitlets
, requests
, nodejs-8_x
, nodePackages
}:

let
  # js/css assets that setup.py tries to fetch via `npm install` when building
  # from source.
  bootstrap = 
    fetchzip {
      url = "https://registry.npmjs.org/bootstrap/-/bootstrap-3.3.7.tgz";
      sha256 = "0r7s54bbf68ri1na9bbabyf12mcpb6zk5ja2q6z82aw1fa4xi3yd";
    };
  font-awesome = 
    fetchzip {
      url = "https://registry.npmjs.org/font-awesome/-/font-awesome-4.7.0.tgz";
      sha256 = "1xnxbdlfdd60z5ix152m8r2kk9dkwlqwpypky1mm3dv64ajnzdbk";
    };
  jquery = 
    fetchzip {
      url = "https://registry.npmjs.org/jquery/-/jquery-3.2.1.tgz";
      sha256 = "1j6y18miwzafdj8kfpwbmbn9qvgnbnpc7l4arqrhqj33m04xrlgi";
    };
  moment = 
    fetchzip {
      url = "https://registry.npmjs.org/moment/-/moment-2.18.1.tgz";
      sha256 = "1b4vyvs24v6y92pf2iqjm5aa7jg7khcpspn00girc7lpi917f9vw";
    };
  requirejs = 
    fetchzip {
      url = "https://registry.npmjs.org/requirejs/-/requirejs-2.3.4.tgz";
      sha256 = "0q6mkj0iv341kks06dya6lfs2kdw0n6vc7n4a7aa3ia530fk9vja";
    };

in

buildPythonPackage rec {
  pname = "jupyterhub";
  version = "0.8.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "100cf18d539802807a45450d38fefbb376cf1c810f3b1b31be31638829a5c69c";
  };

  # Most of this only applies when building from source (e.g. js/css assets are
  # pre-built and bundled in the official release tarball on pypi).
  #
  # Stuff that's always needed:
  #   * At runtime, we need configurable-http-proxy, so we substitute the store
  #     path.
  #
  # Other stuff that's only needed when building from source:
  #   * js/css assets are fetched from npm.
  #   * substitute store path for `lessc` commmand.
  #   * set up NODE_PATH so `lessc` can find `less-plugin-clean-css`.
  #   * don't run `npm install`.
  preBuild = ''
    export NODE_PATH=${nodePackages.less-plugin-clean-css}/lib/node_modules

    substituteInPlace jupyterhub/proxy.py --replace \
      "'configurable-http-proxy'" \
      "'${nodePackages.configurable-http-proxy}/bin/configurable-http-proxy'"

    substituteInPlace jupyterhub/tests/test_proxy.py --replace \
      "'configurable-http-proxy'" \
      "'${nodePackages.configurable-http-proxy}/bin/configurable-http-proxy'"

    substituteInPlace setup.py --replace \
      "'npm', 'run', 'lessc', '--'" \
      "'${nodePackages.less}/bin/lessc'"

    substituteInPlace setup.py --replace \
      "'npm', 'install', '--progress=false'" \
      "'true'"

    declare -A deps
    deps[bootstrap]=${bootstrap}
    deps[font-awesome]=${font-awesome}
    deps[jquery]=${jquery}
    deps[moment]=${moment}
    deps[requirejs]=${requirejs}

    mkdir -p share/jupyter/hub/static/components
    for dep in "''${!deps[@]}"; do
      if [ ! -e share/jupyter/hub/static/components/$dep ]; then
        cp -r ''${deps[$dep]} share/jupyter/hub/static/components/$dep
      fi
    done
  '';

  propagatedBuildInputs = [
    alembic ipython jinja2 pamela python-oauth2 requests sqlalchemy tornado
    traitlets
  ];

  # Disable tests because they take an excessive amount of time to complete.
  doCheck = false;

  meta = with lib; {
    description = "Serves multiple Jupyter notebook instances";
    homepage = http://jupyter.org/;
    license = licenses.bsd3;
    maintainers = with maintainers; [ ixxie cstrahan ];
  };
}
