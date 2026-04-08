{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = false;
      shellInit = /* fish */ ''
        fish_add_path ~/.local/bin
        fish_vi_key_bindings
        fish_add_path ~/.cargo/bin
        fish_add_path ~/.bin
        fish_add_path ~/.nimble/bin
        fish_add_path ~/.config/emacs/bin
        alias ls 'eza --icons'
      '';
    };
    nushell = {
      enable = true;
      configFile.source = ../nushell/config.nu;
    };
   carapace.enable = true;
   carapace.enableNushellIntegration = true;
  };
}
