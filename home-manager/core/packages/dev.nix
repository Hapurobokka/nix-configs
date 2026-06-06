# Funky development utils
# Unironically good distro for this shi
{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.self.packages.${pkgs.system}.nvim
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
    nodejs_26
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
