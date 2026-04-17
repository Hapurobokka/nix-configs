# Funky development utils
# Unironically good distro for this shi
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # qemu_full
    cachix
    cargo
    clang
    direnv
    docker-compose
    godot
    jetbrains.idea
    jetbrains.pycharm
    nodejs_25
    podman-tui
    javaPackages.compiler.temurin-bin.jdk-17
    postman
    claude-code
    python313
    vscode-fhs
    uv
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
