{ inputs, ... }: {
  perSystem = { pkgs, ... }:
  let
    nvimPkg = inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ (inputs.import-tree ./.) ];
    };
  in {
    packages.nvim = nvimPkg.neovim;
  };
}
