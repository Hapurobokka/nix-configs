_: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  }; # Define your hostname.
  services = {
    tailscale.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
