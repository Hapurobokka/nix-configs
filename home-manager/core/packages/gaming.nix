# The most oppressed minority in Earth
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dolphin-emu
    # prismlauncher
    protonup-ng
    deadlock-mod-manager
    ppsspp
    r2modman
    wine
    winetricks
    (retroarch.withCores (
      cores: with cores; [
        beetle-psx-hw
        desmume
        genesis-plus-gx
        melonds
        mgba
        snes9x
        swanstation
      ]
    ))
    melonds
  ];
}
