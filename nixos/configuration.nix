# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, nixos-wsl, ... }:
{
  imports = [
  ];

  i18n.defaultLocale = "es_MX.UTF-8";

  wsl = {
    enable = true;
    defaultUser = "hapu";
    useWindowsDriver = true;
    interop.includePath = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.dejavu-sans-mono
    julia-mono
  ];

  environment.sessionVariables = {
    FLAKE = "/home/hapu/nix-configs";
  };

  environment.systemPackages = with pkgs; [
    git
    gnumake
    home-manager
    wget

    clang
    clang-tools
    gcc

    python3Full

    nix-ld
  ];

  services.dbus.enable = true;
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Mexico_City";

  environment.shells = with pkgs; [ fish ];  # Si usas NuShell
  users.users.hapu.shell = pkgs.fish;       #
  programs.fish.enable = true;

  programs.nix-ld = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
