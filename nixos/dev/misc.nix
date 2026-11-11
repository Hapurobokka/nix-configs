{pkgs, ...}:
{
  nixpkgs.overlays = [
    (final: prev: {
      nautilus = prev.nautilus.overrideAttrs (nprev: {
        buildInputs =
          nprev.buildInputs
          ++ (with pkgs.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
          ]);
      });
    })
  ];
 
  programs = {
    nix-index.enable = true;
    appimage = {
      enable = true;
      package = pkgs.appimage-run.override {
        extraPkgs = p: [ p.icu ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    clang
    neovim
    home-manager
  ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
