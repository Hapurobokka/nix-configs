{ inputs, ... }: {
  perSystem = { pkgs, ... }:
  let
    nvimPkg = inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ (inputs.import-tree ./config) ];  # ← apunta a config/
    };
  in {
    packages.nvim = nvimPkg.neovim;
  };
}
