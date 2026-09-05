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
        extraEntries = ''
          menuentry "Ubuntu ISO" {
            set isofile="/boot-isos/ubuntu.iso"

            search --no-floppy --file --set=root $isofile
            loopback loop $isofile

            linux (loop)/casper/vmlinuz \
              boot=casper iso-scan/filename=$isofile noprompt noeject

            initrd (loop)/casper/initrd
          }
      '';
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
