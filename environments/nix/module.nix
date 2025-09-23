{ inputs, ... }:

{
  imports = with inputs.environment.flakeModules; [ nix ];
}
