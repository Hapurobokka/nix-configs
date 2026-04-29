# Funky development utils
# Unironically good distro for this shi
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # qemu_full
    bun
    cachix
    cargo
    clang
    claude-code
    direnv
    docker-compose
    godot
    javaPackages.compiler.temurin-bin.jdk-17
    jetbrains.idea
    jetbrains.pycharm
    nodejs_25
    podman-tui
    postman
    python313
    uv
    vscode-fhs
    zed-editor-fhs
    (aspellWithDicts (
      dicts: with dicts; [
        es
        en
      ]
    ))
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-medium
        dirtytalk
        wrapfig
        capt-of
        ;
    })
  ];
}
