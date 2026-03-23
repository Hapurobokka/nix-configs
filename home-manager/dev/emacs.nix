{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
      pkgs.python313
      pkgs.uv
      pkgs.clang-tools
    ];
  };
}
