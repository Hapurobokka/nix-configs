{ inputs, ... }:
let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  flake.homeConfigurations."hapu@nixos" = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [
      { nixpkgs.overlays = [ inputs.prism-launcher.overlays.default ]; }
      inputs.nvf.homeManagerModules.default
      inputs.stylix.homeModules.stylix
      (inputs.import-tree [
        ./core
        ./shell
        ./desktop
        ./dev
        ./media
      ])
    ];
    extraSpecialArgs = { inherit inputs; };
  };
}
