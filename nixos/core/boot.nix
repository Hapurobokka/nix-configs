_: {
  # Bootloader
  boot = {
    kernelModules = [ "ntsync" ];
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        devices = [ "nodev" ];
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
