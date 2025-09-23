{
  inputs = {
    environment.url = "git+file://../../..";

    flake-parts.follows = "environment/flake-parts";
    nixpkgs.follows = "environment/nixpkgs";
  };

  outputs = inputs: with inputs; flake-parts.lib.mkFlake { inherit inputs; } (import ./module.nix);
}
