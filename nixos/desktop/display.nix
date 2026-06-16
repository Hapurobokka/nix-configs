{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  services.xserver.enable = true;

  programs = {
    hyprland.enable = false;
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
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
