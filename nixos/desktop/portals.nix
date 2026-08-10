{ pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config = {
      common = {
        default = [ "kde" "gtk" ];
      };
      # programs.niri (nixpkgs) also sets a default here ("gnome;gtk"); override for our gtk/wlr setup.
      niri = lib.mkForce {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
      plasma = {
        default = [ "kde" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "kde" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "kde" ];
      };
    };
  };

  services.flatpak.enable = true;
  programs.appimage.enable = true;
}
