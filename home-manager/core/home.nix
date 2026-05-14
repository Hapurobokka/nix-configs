_: {
  # Main file with some simple settings
  home = {
    stateVersion = "24.05";
    username = "hapu";
    homeDirectory = "/home/hapu";
    sessionVariables = {
      EDITOR = "nvim";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
      GTK_IM_MODULE = "simple";
    };
  };

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-35.7.5"
      "obsidian"
    ];
  };
}
