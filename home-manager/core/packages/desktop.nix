# There was a very cringe comment here but
# I recapacitated.
{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    gearlever
    brave
    firefox
    gimp
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    kdePackages.okular
    inputs.helium.packages.${pkgs.system}.default
    kitty
    nicotine-plus
    obsidian
    papirus-icon-theme
    spotify
    vesktop
    vivaldi
    zapzap
  ];
}
