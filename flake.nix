{
  description = "A very basic flake";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    jj-nvim = {
      url = "github:NicolasGB/jj.nvim";
      flake = false;
    };

    warp-nvim = {
      url = "github:y3owk1n/warp.nvim";
      flake = false;
    };

    prism-launcher = {
      url = "github:Diegiwg/PrismLauncher-Cracked";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
      # vimOverlay = final: prev: {
      #   vimPlugins = prev.vimPlugins // {
      #     jj-nvim = prev.vimUtils.buildVimPlugin {
      #       pname = "jj-nvim";
      #       version = inputs.jj-nvim.lastModifiedDate;
      #       src = inputs.jj-nvim;
      #     };
      #     warp-nvim = prev.vimUtils.buildVimPlugin {
      #       pname = "warp-nvim";
      #       version = inputs.warp-nvim.lastModifiedDate;
      #       src = inputs.warp-nvim;
      #     };
      #   };
      # };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./nixos/configuration.nix
            ./nixos/hardware-configuration.nix
            inputs.nix-index-database.nixosModules.nix-index
            # inputs.nixos-hardware.nixosModules.lenovo-ideapad-15ach6
          ];

          specialArgs = { inherit inputs; };
        };
      };

      homeConfigurations = {
        "hapu@nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            {
              nixpkgs.overlays = [
                # vimOverlay
                inputs.prism-launcher.overlays.default
              ];
            }
            inputs.nvf.homeManagerModules.default
            inputs.stylix.homeModules.stylix
            ./home-manager/home.nix
          ];

          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
