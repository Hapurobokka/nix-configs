# Development tools, editors, and language runtimes.
{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
    bun
    cachix
    cargo
    clang
    claude-code
    docker-compose
    godot
    kakoune
    javaPackages.compiler.temurin-bin.jdk-17
    nixd
    nixfmt
    nodejs_26
    podman-tui
    postman
    python313
    ruby_4_0
    statix
    tree-sitter
    uv
    vscode-fhs
    zed-editor-fhs
    (aspellWithDicts (
      dicts: with dicts; [
        es
        en
      ]
    ))
    (texliveSmall.withPackages (texlive: [
      texlive.scheme-medium
      texlive.dirtytalk
      texlive.wrapfig
      texlive.capt-of
    ]))
  ];
}
