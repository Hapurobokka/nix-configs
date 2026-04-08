{
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    nix-index.enable = true;
    appimage.enable = true;
  };

  environment.systemPackages = with pkgs; [
    clang
    neovim
    home-manager
    inputs.self.packages.${pkgs.system}.nvim
    mongosh
  ];

  services = {
    mongodb = {
      enable = true;
      package = pkgs.mongodb-ce;
    };
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
  };
}
