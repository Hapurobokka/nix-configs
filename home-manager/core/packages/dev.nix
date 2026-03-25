# Funky development utils
# Unironically good distro for this shi
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cachix
    cargo
    clang
    direnv
    docker-compose
    godot
    jetbrains.idea
    jetbrains.pycharm-oss
    nodejs_25
    podman-tui
    postman
    python313
    # qemu_full
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
