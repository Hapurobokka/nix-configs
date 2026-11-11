{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    niri = {
      enable = true;
      # Keep niri's GNOME screencasting, but use GTK instead of Nautilus for file picking.
      useNautilus = false;
    };
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      NH_FLAKE = "/home/hapu/nix-configs";
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      # KDE applications (without the Plasma desktop).
      kdePackages.kdenlive
      kdePackages.gwenview
      kdePackages.ark
      kdePackages.ksystemlog
      kdePackages.partitionmanager

      dunst
      libnotify
      wayland-utils
      xwayland-satellite
    ];
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
}
