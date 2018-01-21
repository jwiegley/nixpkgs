{pkgs, lib}:

with pkgs;

let

  defaultKernelsDefinition = {
    python3 = let
      env = (python3.withPackages (pythonPackages: with pythonPackages; [
              ipykernel
              pandas
              scikitlearn
            ]));
    in {
      displayName = "Python 3";
      argv = [
        "${env}/bin/python"
        "-m"
        "ipykernel_launcher"
        "-f"
        "{connection_file}"
      ];
      language = "python";
      logo32 = "${env.sitePackages}/ipykernel/resources/logo-32x32.png";
      logo64 = "${env.sitePackages}/ipykernel/resources/logo-64x64.png";
    };
  };

in

kernelDefinitions: (

  let

    kernels = if kernelDefinitions == null
      then defaultKernelsDefinition
      else kernelDefinitions;

  in

  with lib; stdenv.mkDerivation rec {

    name = "jupyter-kernels";

    src = "/dev/null";

    unpackCmd ="mkdir jupyter_kernels";

    installPhase =  ''
        mkdir kernels

        ${concatStringsSep "\n" (mapAttrsToList (kernelName: kernel:
          let
            config = builtins.toJSON {
              display_name = if (kernel.displayName != "")
                then kernel.displayName
                else kernelName;
              argv = kernel.argv;
              language = kernel.language;
            };
            logo32 =
              if (kernel.logo32 != null)
              then "ln -s ${kernel.logo32} 'kernels/${kernelName}/logo-32x32.png';"
              else "";
            logo64 =
              if (kernel.logo64 != null)
              then "ln -s ${kernel.logo64} 'kernels/${kernelName}/logo-64x64.png';"
              else "";
          in ''
            mkdir 'kernels/${kernelName}';
            echo '${config}' > 'kernels/${kernelName}/kernel.json';
            ${logo32}
            ${logo64}
          '') kernels)}

        mkdir $out
        cp -r kernels $out
      '';

    meta = {
      description = "Wrapper to create jupyter notebook kernel definitions";
      homepage = http://jupyter.org/;
      # NIXOS license as this is a nixos meta package.
      maintainers = with lib.maintainers; [ aborsu ];
    };

  }
)
