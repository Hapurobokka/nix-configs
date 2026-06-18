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
    inputs.zen-browser.packages.${pkgs.system}.default
    thunar
    kitty
    nicotine-plus
    obsidian
    papirus-icon-theme
    spotify
    vesktop
    vivaldi
    waybar
    wofi
    bluetui
    networkmanagerapplet
    zapzap
  ];
}
