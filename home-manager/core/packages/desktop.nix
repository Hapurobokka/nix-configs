# Desktop applications and fonts.
{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    brave
    firefox
    gimp
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    kdePackages.okular
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ghostty
    kitty
    nicotine-plus
    easyeffects
    obsidian
    hyprpicker
    spotify
    aseprite
    libresprite
    vesktop

    # Fonts.
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];
}
