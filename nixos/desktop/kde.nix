{ pkgs, config, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "breeze";
    };
  };

  # Add KDE-specific portal
  xdg.portal.extraPortals = with pkgs; [
    kdePackages.xdg-desktop-portal-kde
  ];

  # Add KDE-specific environment packages
  environment.systemPackages = with pkgs.kdePackages; [
    dolphin           # File manager
    konsole           # Terminal
    kate              # Text editor
    kdenlive          # Video editor (optional, feel free to remove)
    gwenview          # Image viewer
    spectacle         # Screenshot tool
    ark               # Archive manager
    kcalc             # Calculator
    ksystemlog        # System log viewer
    partitionmanager  # Disk partition manager
  ];
}
