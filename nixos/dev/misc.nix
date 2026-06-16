{pkgs, ...}:
{
  programs = {
    nix-index.enable = true;
    appimage = {
      enable = true;
      package = pkgs.appimage-run.override {
        extraPkgs = p: [ p.icu ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    clang
    neovim
    home-manager
    # inputs.self.packages.${pkgs.system}.nvim
  ];
}
