{ inputs, lib, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];
  programs.noctalia = {
    enable = true;
  };
}
