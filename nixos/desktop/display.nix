{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  programs = {
    hyprland.enable = false;
    niri.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = 1;
      NIXOS_OZONE_WL = 1;
      NH_FLAKE = "/home/hapu/nix-configs";
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      dunst
      gnome-tweaks
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
