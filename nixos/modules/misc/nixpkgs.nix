{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nixpkgs;

  isConfig = x:
    builtins.isAttrs x || builtins.isFunction x;

  optCall = f: x:
    if builtins.isFunction f
    then f x
    else f;

  mergeConfig = lhs_: rhs_:
    let
      lhs = optCall lhs_ { inherit pkgs; };
      rhs = optCall rhs_ { inherit pkgs; };
    in
    lhs // rhs //
    optionalAttrs (lhs ? packageOverrides) {
      packageOverrides = pkgs:
        optCall lhs.packageOverrides pkgs //
        optCall (attrByPath ["packageOverrides"] ({}) rhs) pkgs;
    } //
    optionalAttrs (lhs ? perlPackageOverrides) {
      perlPackageOverrides = pkgs:
        optCall lhs.perlPackageOverrides pkgs //
        optCall (attrByPath ["perlPackageOverrides"] ({}) rhs) pkgs;
    };

  configType = mkOptionType {
    name = "nixpkgs-config";
    description = "nixpkgs config";
    check = traceValIfNot isConfig;
    merge = args: fold (def: mergeConfig def.value) {};
  };

  overlayType = mkOptionType {
    name = "nixpkgs-overlay";
    description = "nixpkgs overlay";
    check = builtins.isFunction;
    merge = lib.mergeOneOption;
  };

  pkgsType = mkOptionType {
    name = "nixpkgs";
    description = "An evaluation of Nixpkgs; the top level attribute set of packages";
    check = builtins.isAttrs;
  };

in

{
  options.nixpkgs = {

    pkgs = mkOption {
      defaultText = literalExample ''
        Situation-dependent; plain NixOS sets the option default to
        import nixpkgs { inherit config overlays system; },
        where nixpkgs is the copy of Nixpkgs that this distribution of
        NixOS comes from; it is part of the same directory tree.
        The arguments are taken from the configuration options in
        config.nixpkgs.
        '';
      default = import ../../.. { inherit (cfg) config overlays system; };
      type = pkgsType;
      example = literalExample ''import <nixpkgs> {}'';
      description = ''
        This is the evaluation of Nixpkgs that will be provided to
        all NixOS modules. Defining this option has the effect of
        ignoring the other options that would otherwise be used to
        evaluate Nixpkgs.

        This can be used by applications like NixOps to increase the
        performance of evaluation, or by packages that depend on a
        container that should be built with the exact same evaluation
        of Nixpkgs, for example. Applications like this should set
        their default value using <code>lib.mkDefault</code>, so
        user-provided configuration can override it without using
        <code>lib</code>.
      '';
    };

    config = mkOption {
      default = {};
      example = literalExample
        ''
          { firefox.enableGeckoMediaPlayer = true; }
        '';
      type = configType;
      description = ''
        The configuration of the Nix Packages collection.  (For
        details, see the Nixpkgs documentation.)  It allows you to set
        package configuration options.

        Ignored when <code>nixpkgs.pkgs</code> is set.
      '';
    };

    overlays = mkOption {
      default = [];
      example = literalExample
        ''
          [ (self: super: {
              openssh = super.openssh.override {
                hpnSupport = true;
                withKerberos = true;
                kerberos = self.libkrb5;
              };
            };
          ) ]
        '';
      type = types.listOf overlayType;
      description = ''
        List of overlays to use with the Nix Packages collection.
        (For details, see the Nixpkgs documentation.)  It allows
        you to override packages globally. This is a function that
        takes as an argument the <emphasis>original</emphasis> Nixpkgs.
        The first argument should be used for finding dependencies, and
        the second should be used for overriding recipes.

        Ignored when <code>nixpkgs.pkgs</code> is set.
      '';
    };

    system = mkOption {
      type = types.str;
      example = "i686-linux";
      description = ''
        Specifies the Nix platform type for which NixOS should be built.
        If unset, it defaults to the platform type of your host system.
        Specifying this option is useful when doing distributed
        multi-platform deployment, or when building virtual machines.

        Ignored when <code>nixpkgs.pkgs</code> is set.
      '';
    };
  };

  config = {
    _module.args = {
      pkgs = cfg.pkgs;
      pkgs_i686 = cfg.pkgs.pkgsi686Linux;
    };
  };
}
