{ ... }:
{
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "gtk" ];
      };
      hyprland = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
      };
      # programs.niri supplies GNOME screencasting and GTK file picking.
      # Both compositor modules also supply their required portal backends.
    };
  };

  services.flatpak.enable = true;
  programs.appimage.enable = true;
}
