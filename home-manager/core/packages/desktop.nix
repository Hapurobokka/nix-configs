# There was a very cringe comment here but
# I recapacitated.
{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    brave
    firefox
    gimp
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    kdePackages.okular
    # inputs.helium.packages.${pkgs.system}.default
    inputs.zen-browser.packages.${pkgs.system}.default
    kitty
    nicotine-plus
    easyeffects
    obsidian
    papirus-icon-theme
    hyprpicker
    spotify
    aseprite
    libresprite
    vesktop
    # waybar
    # wofi
    # bluetui
    # networkmanagerapplet
    # zapzap
  ];
}
