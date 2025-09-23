{ config, ... }:

{
  flake.flakeModules.nix = { ... }: {
    imports = with config.flake.flakeModules; [ global ];

    perSystem = { ... }: {
      make-shells.default = {
        name = "nix";
      };

      pre-commit.settings.hooks = {
        nil.enable = true;
        flake-checker.enable = true;
        pre-commit-hook-ensure-sops.enable = true;
      };

      treefmt.programs = {
        nixpkgs-fmt.enable = true;
        statix.enable = true;
        deadnix.enable = true;
        nixf-diagnose.enable = true;

        statix.disabled-lints = [ "empty_pattern" "repeated_keys" ];
      };
    };
  };
}
