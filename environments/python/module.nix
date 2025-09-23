{ inputs, ... }:

{
  imports = with inputs.environment.flakeModules; [ python ];
}
