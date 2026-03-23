# There was a very cringe comment here but
# I recapacitated.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    firefox
    gimp
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    kdePackages.okular
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
