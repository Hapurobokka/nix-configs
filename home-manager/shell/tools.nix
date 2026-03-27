{ pkgs, ... }:
{
  programs = {
    atuin = {
      enable = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = false;
      enableNushellIntegration = true;
    };
    yazi = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      settings.mgr.show_hidden = true;
      shellWrapperName = "y";
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    tmux = {
      enable = false;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        catppuccin
        vim-tmux-navigator
        tmux-floax
      ];
      extraConfig = ''
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"
        set -g mouse on
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on
        unbind C-b
        set -g prefix C-Space
      '';
    };
    ghostty = {
      enable = true;
      settings = {
        font-family = "JetBrains Mono";
        theme = "Kanagawa Wave";
        background-opacity = 0.8;
        font-size = 11;
        background-blur = true;
      };
    };
  };
}
