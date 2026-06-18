_: {
  imports = [{
    wayland.windowManager.hyprland.enable = lib.mkForce true;
  }];
  warnings = [ "hyprland.nix IS being loaded via warnings" ];
}
