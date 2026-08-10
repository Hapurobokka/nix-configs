{ pkgs, ... }:
{
  services.xserver.enable = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    niri = {
      enable = true;
      # Portal is managed explicitly in nixos/desktop/portals.nix (gtk/wlr, not gnome).
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
