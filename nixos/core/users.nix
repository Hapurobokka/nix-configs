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
      nautilus
      gparted-full
      evsieve
    ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
}
