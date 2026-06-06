# The most oppressed minority in Earth
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dolphin-emu
    # prismlauncher
    protonup-ng
    r2modman
    lutris
    wine
    winetricks
    (retroarch.withCores (
      cores: with cores; [
        genesis-plus-gx
        snes9x
        beetle-psx-hw
        melonds
        mgba
        desmume
      ]
    ))
    melonds
  ];
}
