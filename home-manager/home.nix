{ config, pkgs, inputs, ... }:
let
  myTex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium
      dirtytalk
      wrapfig
      capt-of;
  });
in
{
  imports = [
    ./helix.nix
    ./nixvim.nix
    ./hypr.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home.username = "hapu";
  home.homeDirectory = "/home/hapu";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # atuin
    # black
    # deno
    # evcxr
    # haskell.compiler.ghc983
    # litecli
    # lua-language-server
    # lua51Packages.lua
    # luajitPackages.luarocks
    # nethack
    # nodePackages.prettier
    # nodePackages.typescript-language-server
    # nodejs_22
    # nushell
    # porsmo
    # pyright
    # rubocop
    # ruby-lsp
    # rust-analyzer
    # sqlite
    # texlab
    # tree-sitter-grammars.tree-sitter-norg
    # typescript
    # universal-ctags
    # vscode-langservers-extracted
    # wsl-open
    # xclip
    # yarn-berry
    (aspellWithDicts (dicts: with dicts; [ es en ]))
    bacon
    bat
    cargo
    chafa
    cmake
    emacs
    eza
    fastfetch
    fd
    fish
    fossil
    fzf
    gdb
    helix
    hello
    inputs.zen-browser.packages.${pkgs.system}.default
    just
    kitty
    lazygit
    libtool
    myTex
    nerd-fonts.jetbrains-mono
    nh
    nix-output-monitor
    nixd
    octaveFull
    pandoc
    pylint
    python312Packages.bpython
    ripgrep
    rm-improved
    ruby
    rustc
    sbcl
    starship
    tldr
    tmux
    tree-sitter
    valgrind
    vesktop
    yazi
    zellij
    zoxide
    zapzap
    # wofi
    hyprshot
    rofi-wayland
    
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.git = {
    enable = true;
    userName = "Hapurobokka";
    userEmail = "flaco.legos@gmail.com";
  };

  programs.zoxide = {
    enable = true;
    # enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.fish = {
      enable = false;
      shellInit = /*fish*/ ''
        fish_add_path ~/.local/bin
        alias ls 'eza'
      '';
  };


  programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [ sensible catppuccin vim-tmux-navigator tmux-floax tmux-which-key ];
      extraConfig = ''
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        unbind C-b
        set -g prefix C-Space
      '';
    };

  programs.nushell = {
    enable = true;
    extraConfig = /*nu*/ ''
      $env.config.buffer_editor = "nvim"
      $env.config.show_banner = false
      $env.__zoxide_hooked = true
    '';
  };

  catppuccin = {
    flavor = "frappe";
    enable = true;
  };

  # programs.zellij = {
  #   enable = true;
  #   settings = {
  #     theme = "kanagawa";
  #     pane_frames = false;
  #   };
  # };

  programs.starship = {
    enable = true;
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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
