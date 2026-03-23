_: {
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    containers.containersConf.settings = {
      network.default_subnet_pools = [
        {
          base = "10.89.0.0/16";
          size = 24;
        }
        {
          base = "10.90.0.0/16";
          size = 24;
        }
        {
          base = "10.91.0.0/16";
          size = 24;
        }
        {
          base = "10.92.0.0/16";
          size = 24;
        }
        {
          base = "10.93.0.0/16";
          size = 24;
        }
        {
          base = "10.94.0.0/16";
          size = 24;
        }
        {
          base = "10.95.0.0/16";
          size = 24;
        }
        {
          base = "10.96.0.0/16";
          size = 24;
        }
        {
          base = "172.20.0.0/16";
          size = 24;
        }
        {
          base = "172.21.0.0/16";
          size = 24;
        }
        {
          base = "172.22.0.0/16";
          size = 24;
        }
        {
          base = "172.23.0.0/16";
          size = 24;
        }
        {
          base = "192.168.100.0/16";
          size = 24;
        }
        {
          base = "192.168.110.0/16";
          size = 24;
        }
      ];
    };
    waydroid.enable = true;
  };
}
