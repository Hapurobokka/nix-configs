{ inputs, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # { nixpkgs.overlays = [ inputs.millennium.overlays.default ]; }
      ./hardware/_generated/hardware-configuration.nix
      (inputs.import-tree [
        ./core
        ./desktop
        ./hardware
        ./games
        ./dev
      ])
      inputs.niri.nixosModules.niri
      inputs.nix-index-database.nixosModules.default
      inputs.nixos-hardware.nixosModules.lenovo-ideapad-15ach6
      {
        nix.settings = {
          substituters = [
            "https://cache.nixos.org"
            "https://cuda-maintainers.cachix.org"
          ];
          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "cuda-maintainers.cachix.org-1:FeO8oa6qi8uHRQmMRaHHHhSMBqqkxHJNJFbnNbMsxVc="
          ];
        };
      }
    ];
    specialArgs = {
      inherit inputs;
      inherit (inputs) self;
      pkgs-stable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };
  };
}
