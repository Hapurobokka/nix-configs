{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
      pkgs.python313
      pkgs.uv
      pkgs.clang-tools
      pkgs.ty
      pkgs.ruff
      pkgs.sqlite
    ];
  };
}
