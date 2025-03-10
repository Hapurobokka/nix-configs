{
  description = "A very basic flake";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # needed for WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { nixpkgs, nixos-wsl, home-manager, nixvim, ... } @ inputs: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in 
  {

    nixosConfigurations = {
      myNixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          nixos-wsl.nixosModules.default
          ./nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "hapu@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
	  nixvim.homeManagerModules.nixvim
	  ./home-manager/home.nix
	];

        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
