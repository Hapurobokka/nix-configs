{ ... }:
{
  programs = {
    atuin = {
      enable = true;
      enableFishIntegration = false;
      enableNushellIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = false;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      presets = [ "pure-preset" ];
    };
    yazi = {
      enable = true;
      enableFishIntegration = false;
      enableNushellIntegration = true;
      settings.mgr.show_hidden = true;
      shellWrapperName = "y";
    };
    zoxide = {
      enable = true;
      enableFishIntegration = false;
      enableNushellIntegration = true;
    };
  };
}
