{ pkgs, ... }:
{
  hardware.steam-hardware.enable = true;

  services.udev.extraRules = ''
    # DualSense (USB) - prevent touchpad from being treated as a system mouse
    SUBSYSTEM=="input", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", KERNEL=="event*", ENV{ID_INPUT_TOUCHPAD}="0", ENV{ID_INPUT_MOUSE}="0"
    # DualSense (Bluetooth) - same fix for wireless connection
    SUBSYSTEM=="input", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0df2", KERNEL=="event*", ENV{ID_INPUT_TOUCHPAD}="0", ENV{ID_INPUT_MOUSE}="0"
  '';

  programs.steam = {
    package = pkgs.steam;
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;
  environment.systemPackages = [ pkgs.mangohud ];
}
