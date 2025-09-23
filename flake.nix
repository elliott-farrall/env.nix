{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    systems.url = "github:nix-systems/default";

    make-shell.url = "github:nicknovitski/make-shell";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    git-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: with inputs; flake-parts.lib.mkFlake { inherit inputs; } (import-tree ./modules);
}
