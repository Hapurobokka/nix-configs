{ pkgs, ... }:
{
  programs.steam = {
    package = pkgs.millennium-steam;
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
