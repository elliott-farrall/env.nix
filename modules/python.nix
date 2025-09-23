{ config, ... }:

{
  flake.flakeModules.python = { ... }: {
    imports = with config.flake.flakeModules; [ global ];

    perSystem = { pkgs, ... }: {
      make-shells.default = {
        name = "python";

        packages = with pkgs; [
          poetry
          python310
        ];

        env = {
          LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
          POETRY_VIRTUALENVS_IN_PROJECT = true;
        };

        shellHook = ''
          poetry env use $(which python)
          poetry install
        '';
      };

      pre-commit.settings.hooks = {
        check-python.enable = true;

        poetry-check.enable = true;
        poetry-lock.enable = true;
      };

      treefmt.programs = {
        ruff-check.enable = true;
        ruff-format.enable = true;
      };
    };
  };
}
