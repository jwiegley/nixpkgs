{ system, minimal ? false, config ? {} }:

with import ./build-vms.nix { inherit system minimal config; };
with pkgs;

rec {

  inherit pkgs;


  testDriver = stdenv.mkDerivation {
    name = "nixos-test-driver";

    buildInputs = [ makeWrapper perl ];

    unpackPhase = "true";

    preferLocalBuild = true;

    installPhase =
      ''
        mkdir -p $out/bin
        cp ${./test-driver/test-driver.pl} $out/bin/nixos-test-driver
        chmod u+x $out/bin/nixos-test-driver

        libDir=$out/lib/perl5/site_perl
        mkdir -p $libDir
        cp ${./test-driver/Machine.pm} $libDir/Machine.pm
        cp ${./test-driver/Logger.pm} $libDir/Logger.pm

        wrapProgram $out/bin/nixos-test-driver \
          --prefix PATH : "${lib.makeBinPath [ qemu vde2 netpbm coreutils ]}" \
          --prefix PERL5LIB : "${with perlPackages; lib.makePerlPath [ TermReadLineGnu XMLWriter IOTty FileSlurp ]}:$out/lib/perl5/site_perl"
      '';
  };


  # Run an automated test suite in the given virtual network.
  # `driver' is the script that runs the network.
  runTests = driver:
    stdenv.mkDerivation {
      name = "vm-test-run-${driver.testName}";

      requiredSystemFeatures = [ "kvm" "nixos-test" ];

      buildInputs = [ libxslt ];

      buildCommand =
        ''
          mkdir -p $out/nix-support

          LOGFILE=$out/log.xml tests='eval $ENV{testScript}; die $@ if $@;' ${driver}/bin/nixos-test-driver

          # Generate a pretty-printed log.
          xsltproc --output $out/log.html ${./test-driver/log2html.xsl} $out/log.xml
          ln -s ${./test-driver/logfile.css} $out/logfile.css
          ln -s ${./test-driver/treebits.js} $out/treebits.js
          ln -s ${jquery}/js/jquery.min.js $out/
          ln -s ${jquery-ui}/js/jquery-ui.min.js $out/

          touch $out/nix-support/hydra-build-products
          echo "report testlog $out log.html" >> $out/nix-support/hydra-build-products

          for i in */xchg/coverage-data; do
            mkdir -p $out/coverage-data
            mv $i $out/coverage-data/$(dirname $(dirname $i))
          done
        ''; # */
    };


  makeTest =
    { testScript
    , makeCoverageReport ? false
    , enableOCR ? false
    , name ? "unnamed"
    , ...
    } @ t:

    let
      testDriverName = "nixos-test-driver-${name}";

      nodes = buildVirtualNetwork (
        t.nodes or (if t ? machine then { machine = t.machine; } else { }));

      testScript' =
        # Call the test script with the computed nodes.
        if builtins.isFunction testScript
        then testScript { inherit nodes; }
        else testScript;

      vlans = map (m: m.config.virtualisation.vlans) (lib.attrValues nodes);

      vms = map (m: m.config.system.build.vm) (lib.attrValues nodes);

      ocrProg = tesseract_4.override { enableLanguages = [ "eng" ]; };

      # Generate onvenience wrappers for running the test driver
      # interactively with the specified network, and for starting the
      # VMs from the command line.
      driver = runCommand testDriverName
        { buildInputs = [ makeWrapper];
          testScript = testScript';
          preferLocalBuild = true;
          testName = name;
        }
        ''
          mkdir -p $out/bin
          echo "$testScript" > $out/test-script
          ln -s ${testDriver}/bin/nixos-test-driver $out/bin/
          vms=($(for i in ${toString vms}; do echo $i/bin/run-*-vm; done))
          wrapProgram $out/bin/nixos-test-driver \
            --add-flags "''${vms[*]}" \
            ${lib.optionalString enableOCR
              "--prefix PATH : '${ocrProg}/bin:${imagemagick}/bin'"} \
            --run "testScript=\"\$(cat $out/test-script)\"" \
            --set testScript '$testScript' \
            --set VLANS '${toString vlans}'
          ln -s ${testDriver}/bin/nixos-test-driver $out/bin/nixos-run-vms
          wrapProgram $out/bin/nixos-run-vms \
            --add-flags "''${vms[*]}" \
            ${lib.optionalString enableOCR "--prefix PATH : '${ocrProg}/bin'"} \
            --set tests 'startAll; joinAll;' \
            --set VLANS '${toString vlans}' \
            ${lib.optionalString (builtins.length vms == 1) "--set USE_SERIAL 1"}
        ''; # "

      passMeta = drv: drv // lib.optionalAttrs (t ? meta) {
        meta = (drv.meta or {}) // t.meta;
      };

      test = passMeta (runTests driver);
      report = passMeta (releaseTools.gcovReport { coverageRuns = [ test ]; });

    in (if makeCoverageReport then report else test) // { 
      inherit nodes driver test; 
    };

  runInMachine =
    { drv
    , machine
    , preBuild ? ""
    , postBuild ? ""
    , ... # ???
    }:
    let
      vm = buildVM { }
        [ machine
          { key = "run-in-machine";
            networking.hostName = "client";
            nix.readOnlyStore = false;
          }
        ];

      buildrunner = writeText "vm-build" ''
        source $1

        ${coreutils}/bin/mkdir -p $TMPDIR
        cd $TMPDIR

        exec $origBuilder $origArgs
      '';

      testScript = ''
        startAll;
        $client->waitForUnit("multi-user.target");
        ${preBuild}
        $client->succeed("env -i ${bash}/bin/bash ${buildrunner} /tmp/xchg/saved-env >&2");
        ${postBuild}
        $client->succeed("sync"); # flush all data before pulling the plug
      '';

      vmRunCommand = writeText "vm-run" ''
        xchg=vm-state-client/xchg
        ${coreutils}/bin/mkdir $out
        ${coreutils}/bin/mkdir -p $xchg

        for i in $passAsFile; do
          i2=''${i}Path
          _basename=$(${coreutils}/bin/basename ''${!i2})
          ${coreutils}/bin/cp ''${!i2} $xchg/$_basename
          eval $i2=/tmp/xchg/$_basename
          ${coreutils}/bin/ls -la $xchg
        done

        unset i i2 _basename
        export | ${gnugrep}/bin/grep -v '^xchg=' > $xchg/saved-env
        unset xchg

        export tests='${testScript}'
        ${testDriver}/bin/nixos-test-driver ${vm.config.system.build.vm}/bin/run-*-vm
      ''; # */

    in
      lib.overrideDerivation drv (attrs: {
        requiredSystemFeatures = [ "kvm" ];
        builder = "${bash}/bin/sh";
        args = ["-e" vmRunCommand];
        origArgs = attrs.args;
        origBuilder = attrs.builder;
      });


  runInMachineWithX = { require ? [], ... } @ args:
    let
      client =
        { config, pkgs, ... }:
        {
          inherit require;
          virtualisation.memorySize = 1024;
          services.xserver.enable = true;
          services.xserver.displayManager.select = "auto";
          services.xserver.windowManager.select = [ "icewm" ];
        };
    in
      runInMachine ({
        machine = client;
        preBuild =
          ''
            $client->waitForX;
          '';
      } // args);


  simpleTest = as: (makeTest as).test;

}
