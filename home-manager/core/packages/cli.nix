# Packages with command-line utilities
{ pkgs, pkgs-stable, ... }:
{
  home.packages = with pkgs; [
    acpi
    bat
    brightnessctl
    btop
    cava
    chafa
    codex
    cowsay
    eza
    fd
    fff
    ffmpeg
    ffmpegthumbnailer
    fossil
    fsel
    fzf
    graphviz
    grex
    jujutsu
    just
    kew
    gh
    wtype
    (nnn.override {
      withNerdIcons = true;
    })
    lazygit
    mediainfo
    mpc
    nb
    ncpamixer
    ncspot
    # Work around a broken ELF layout in the unstable build.
    pkgs-stable.rar
    p7zip
    nh
    nitch
    nix-output-monitor
    nvidia-container-toolkit
    playerctl
    poppler-utils
    porsmo
    presenterm
    rassumfrassum
    ripgrep
    typst
    rm-improved
    television
    tldr
    tmux
    unzip
    vips
    wl-clipboard
    zellij
    zip
  ];
}
