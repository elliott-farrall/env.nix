{ inputs, ... }:

{
  imports = with inputs; [ flake-parts.flakeModules.flakeModules ];

  flake.flakeModules.global = { ... }: {
    imports = with inputs; [
      make-shell.flakeModules.default
      git-hooks-nix.flakeModule
      treefmt-nix.flakeModule
    ];

    systems = import inputs.systems;

    perSystem = { self', config, ... }: {
      make-shells.default.inputsFrom = with config.pre-commit; [ devShell ];

      pre-commit.settings.hooks = {
        treefmt = {
          enable = true;
          package = self'.formatter;
        };

        # Config
        check-json.enable = true;
        check-yaml.enable = true;
        check-toml.enable = true;

        # Docs
        markdownlint.enable = true;
        check-vcs-permalinks.enable = true;

        markdownlint.settings.configuration = {
          line-length = false;
        };

        # Git
        check-added-large-files.enable = true;
        forbid-new-submodules.enable = true;

        # All
        editorconfig-checker.enable = true;
        end-of-file-fixer.enable = true;
        trim-trailing-whitespace.enable = true;
        detect-private-keys.enable = true;
        ripsecrets.enable = true;
      };

      treefmt = {
        projectRootFile = ".git/config";

        programs = {
          # Config
          jsonfmt.enable = true;
          yamlfmt.enable = true;
          taplo.enable = true;
          actionlint.enable = true;

          # Docs
          mdformat.enable = true;
          typos.enable = true;
          autocorrect.enable = true;

          # Scripts
          beautysh.enable = true;
          shfmt.enable = true;
        };
      };
    };
  };
}
