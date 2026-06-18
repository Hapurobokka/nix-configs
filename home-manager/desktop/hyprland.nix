{ ... }:
{
  programs.hyprlock.enable = false;
  services.hypridle.enable = false;
  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = {
    enable     = true;
    configType = "lua";

    extraLuaFiles."config" = {
      content  = ./hyprland.lua;
      autoLoad = true;
    };
  };
}
