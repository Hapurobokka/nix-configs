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

    extraLuaFiles."config" = {
      content  = ./hyprland.lua;
      autoLoad = true;
    };
  };
}
