{ config, pkgs, inputs, ... }:
let
  myTex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium
      dirtytalk
      wrapfig
      capt-of;
  };
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./helix.nix
    ./hypr.nix
    ./nvf-configuration.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home = {
    stateVersion = "24.05"; # Please read the comment before changing.
    username = "hapu";
    homeDirectory = "/home/hapu";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-35.7.5"
    "obsidian"
  ];
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (aspellWithDicts (dicts: with dicts; [ es en ]))
    # qemu_full
    acpi
    bat
    brave
    cargo
    cataclysm-dda
    cava
    chafa
    # chiaki-ng
    clang
    cmake
    daggerfall-unity
    direnv
    docker-compose
    eza
    fastfetch
    fd
    fzf
    gfn-electron
    gimp
    gnomeExtensions.blur-my-shell
    godot
    helix
    hyprshot
    jujutsu
    just
    kdePackages.okular
    kew
    lazygit
    mpc
    mpd
    myTex
    mysql-workbench
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nh
    nicotine-plus
    nitch
    nix-output-monitor
    obsidian
    papirus-icon-theme
    playerctl
    podman-compose
    podman-tui
    ppsspp
    presenterm
    protonup
    python313
    r2modman
    ripgrep
    rm-improved
    starship
    tldr
    tmux
    tree-sitter
    vesktop
    vscode-fhs
    waybar
    wl-clipboard
    wofi
    zapzap
    zoxide
    vivaldi
    zellij
    wine
    lutris
    winetricks
    bottles
    zed-editor-fhs
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm pkgs.python313 ];
  };

  programs.zen-browser.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableNushellIntegration = true;
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "Hapurobokka";
      email = "flaco.legos@gmail.com";
    };
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
  };

  programs.fish = {
      enable = false;
      shellInit = /*fish*/ ''
        fish_vi_key_bindings
        fish_add_path ~/.local/bin
        fish_add_path ~/.cargo/bin
        fish_add_path ~/.bin
        alias ls 'eza --icons'
        source ~/nix-configs/home-manager/scripts/dices.fish
      '';
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty";
        width = 25;
        source = ./images/vivian-aaaa.jpg;
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

  programs.tmux = {
      enable = true;
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

        # Start windows and panes at 1
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        unbind C-b
        set -g prefix C-Space
      '';
    };

  programs.nushell = {
    enable = true;
    extraConfig = /*nu*/ ''
      use std/util "path add"
      $env.config.buffer_editor = "nvim"
      $env.config.show_banner = false
      $env.__zoxide_hooked = true
      $env.config.edit_mode = "vi"

      path add "~/.emacs.d/bin"
      source ~/nix-configs/home-manager/scripts/dices.nu
    '';
  };

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = false;
    settings = {
      mgr = {
        show_hidden = true;
      };
    };
  };

  programs.starship = {
    enableFishIntegration = true;
    enable = true;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Kanagawa Wave";
      background-opacity = 0.8;
      font-size = 11;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    "${config.xdg.configHome}/nvim/spell/es.latin1.spl".source = ./neovim/spell/es.latin1.spl;
    "${config.xdg.configHome}/nvim/spell/es.latin1.sug".source = ./neovim/spell/es.latin1.sug;
    "${config.xdg.configHome}/nvim/spell/es.utf-8.spl".source = ./neovim/spell/es.utf-8.spl;
    "${config.xdg.configHome}/nvim/spell/es.utf-8.sug".source = ./neovim/spell/es.utf-8.sug;
    "${config.xdg.configHome}/zellij/config.kdl".source = ./config.kdl;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hapu/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/stella.yaml";
    image = ./images/firefly-gato.jpeg;
    targets = {
      neovim.enable = false;
      nixvim.enable = false;
      nvf.enable = false;
      emacs.enable = false;
      zen-browser.enable = false;
      ghostty.enable = false;
      fish.enable = false;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
