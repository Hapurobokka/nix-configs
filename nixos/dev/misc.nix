{ pkgs, ... }:
{
  programs = {
    nix-index.enable = true;
    appimage.enable = true;
  };

  environment.systemPackages = with pkgs; [
    clang
    neovim
    home-manager
  ];
}
