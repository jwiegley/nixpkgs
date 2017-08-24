/* Impure default args for `pkgs/top-level/default.nix`. See that file
   for the meaning of each argument. */

with builtins;

let

  homeDir = builtins.getEnv "HOME";

  # Return ‘x’ if it evaluates, or ‘def’ if it throws an exception.
  try = x: def: let res = tryEval x; in if res.success then res.value else def;

in

{ # We combine legacy `system` and `platform` into `localSystem`, if
  # `localSystem` was not passed. Strictly speaking, this is pure desugar, but
  # it is most convient to do so before the impure `localSystem.system` default,
  # so we do it now.
  localSystem ? builtins.intersectAttrs { system = null; platform = null; } args

, # These are needed only because nix's `--arg` command-line logic doesn't work
  # with unnamed parameters allowed by ...
  system ? localSystem.system
, platform ? localSystem.platform
, crossSystem ? null

, # Fallback: The contents of the configuration file found at <nixpkgs-config> or
  # $HOME/.config/nixpkgs/config.nix.
  config ? let
      isDir = path: pathExists (path + "/.");
      configFile = try <nixpkgs-config> "";
      configFile2 = homeDir + "/.config/nixpkgs/config.nix";
      configFile3 = homeDir + "/.nixpkgs/config.nix"; # obsolete
    in
      if configFile != "" && pathExists configFile then
        if isDir configFile then 
          throw (configFile + " must be a file")
        else import configFile
      else if configFile2 != "" && pathExists configFile2 then
        if isDir configFile2 then 
          throw (configFile2 + " must be a file")
        else import configFile2
      else if configFile3 != "" && pathExists configFile3 then 
        if isDir configFile3 then
          throw (configFile3 + " must be a file")
        else import configFile3
      else {}

, # Overlays are used to extend Nixpkgs collection with additional
  # collections of packages.  These collection of packages are part of the
  # fix-point made by Nixpkgs.
  overlays ? let
      isDir = path: pathExists (path + "/.");
      pathOverlays = try <nixpkgs-overlays> "";
      homeOverlaysFile = homeDir + "/.config/nixpkgs/overlays.nix";
      homeOverlaysDir = homeDir + "/.config/nixpkgs/overlays";
      overlays = path:
        # check if the path is a directory or a file
        if isDir path then
          # it's a directory, so the set of overlays from the directory, ordered lexicographically
          let content = readDir path; in
          map (n: import (path + ("/" + n)))
            (builtins.filter (n: builtins.match ".*\.nix" n != null || pathExists (path + ("/" + n + "/default.nix")))
              (attrNames content))
        else 
          # it's a file, so the result is the contents of the file itself
          import path;
    in
      if pathOverlays != "" && pathExists pathOverlays then overlays pathOverlays
      else if pathExists homeOverlaysFile && pathExists homeOverlaysDir then 
        throw ''
          Nixpkgs overlays can be specified with ${homeOverlaysFile} or ${homeOverlaysDir}, but not both.
          Please remove one of them and try again.
        ''
      else if pathExists homeOverlaysFile then 
        if isDir homeOverlaysFile then 
          throw (homeOverlaysFile + " should be a file")
        else overlays homeOverlaysFile
      else if pathExists homeOverlaysDir then
        if !(isDir homeOverlaysDir) then 
          throw (homeOverlaysDir + " should be a directory")
        else overlays homeOverlaysDir
      else []

, ...
} @ args:

# If `localSystem` was explicitly passed, legacy `system` and `platform` should
# not be passed.
assert args ? localSystem -> !(args ? system || args ? platform);

import ./. (builtins.removeAttrs args [ "system" "platform" ] // {
  inherit config overlays crossSystem;
  # Fallback: Assume we are building packages on the current (build, in GNU
  # Autotools parlance) system.
  localSystem = { system = builtins.currentSystem; } // localSystem;
})
