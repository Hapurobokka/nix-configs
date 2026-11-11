{ ... }:
{
  programs.hyprlock.enable = false;
  services.hypridle.enable = false;
  services.hyprpolkitagent.enable = true;

  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Imágenes/Capturas de pantalla";
  };

  wayland.windowManager.hyprland = {
    enable     = true;
    configType = "lua";
    # NixOS supplies the portal backend and routing for both compositors.
    portalPackage = null;

    extraLuaFiles."config" = {
      content  = ./hyprland.lua;
      autoLoad = true;
    };
  };
}
