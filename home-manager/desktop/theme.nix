{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/stella.yaml";
    polarity = "dark";
    image = ../images/Snapshot_Perlica_5.png;
    targets = {
      neovim.enable = false;
      nixvim.enable = false;
      nvf.enable = false;
      emacs.enable = false;
      zen-browser.enable = true;
      ghostty.enable = false;
      fish.enable = false;
      helix.enable = false;
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty";
        width = 25;
        source = ../images/Snapshot_Last_Rite_3.png;
        padding = {
          top = 0;
          right = 2;
        };
      };
      modules = [
        "title"
        "separator"
        "os"
        "packages"
        "disk"
        "shell"
        "de"
        "wm"
        "terminal"
        "datetime"
        "editor"
        "colors"
      ];
    };
  };
}
