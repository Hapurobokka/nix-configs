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
    inputs.spotifast.packages."${pkgs.stdenv.hostPlatform.system}".default
    inputs.zapfast.packages."${pkgs.stdenv.hostPlatform.system}".default
    aseprite
    libresprite
    # vesktop
    # waybar
    # wofi
    # bluetui
    # networkmanagerapplet
    # zapzap
  ];

  xdg.desktopEntries.spotifast = {
    name = "Spotifast";
    genericName = "Music Player";
    comment = "A native Spotify client";
    exec = "nvidia-offload spotifast %u";
    icon = "spotifast";
    categories = [ "AudioVideo" "Audio" "Player" "Music" ];
    mimeType = [ "x-scheme-handler/spotify" ];
    startupNotify = true;
    settings = {
      Keywords = "spotify;music;player;streaming;spotifast;";
      StartupWMClass = "spotifast";
    };
  };

  xdg.desktopEntries.zapfast = {
    name = "ZapFast";
    genericName = "WhatsApp Client";
    comment = "A native WhatsApp client";
    exec = "nvidia-offload zapfast %U";
    icon = "zapfast";
    categories = [ "Network" "InstantMessaging" "Chat" ];
    mimeType = [ "x-scheme-handler/whatsapp" "x-scheme-handler/wa" ];
    settings = {
      Keywords = "whatsapp;chat;messaging;";
      StartupWMClass = "zapfast";
    };
  };
}
