{ inputs, ... }:
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./hardware/_generated/hardware-configuration.nix
      (inputs.import-tree [
        ./core
        ./desktop
        ./hardware
        ./games
        ./dev
      ])
      inputs.nix-index-database.nixosModules.default
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
