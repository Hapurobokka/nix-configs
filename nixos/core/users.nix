{ pkgs, ... }:
{
  users.users.hapu = {
    isNormalUser = true;
    description = "Hapurobokka";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      qbittorrent
    ];
    shell = pkgs.nushell;
  };
  programs.fish.enable = false;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
}
