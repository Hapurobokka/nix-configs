{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        STOP_CHARGE_THRESH_BAT0 = 1;
      };
    };
    thermald.enable = true;
    tailscale.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    flatpak = {
      enable = true;
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };
    logmein-hamachi.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xserver.xkb = {
      layout = "latam";
      variant = "";
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  security.rtkit.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # boot.kernelPackages = pkgs.linuxPackages_zen;

  programs = {
    appimage.enable = true;
    nix-index.enable = true;
    hyprland.enable = false;
    niri.enable = true;
    fish.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    gamemode.enable = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  }; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_MX.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.

  # services = {
  #   desktopManager.plasma6.enable = true;
  #   displayManager = {
  #     defaultSession = "plasma";
  #     sddm = {
  #       enable = true;
  #       wayland.enable = true;
  #     };
  #   };
  # };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = 1;
      NIXOS_OZONE_WL = 1;
      NH_FLAKE = "/home/hapu/nix-configs";
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      clang
      dunst
      home-manager
      gnome-tweaks
      libnotify
      neovim
      wayland-utils
      xwayland-satellite
      fuzzel
    ];
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };

  console.keyMap = "la-latin1";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hapu = {
    isNormalUser = true;
    description = "Hapurobokka";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      ghostty
      qbittorrent
      #  thunderbird
    ];
    # shell = pkgs.nushell;
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    containers.containersConf.settings = {
      network = {
        default_subnet_pools = [
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
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib # libstdc++
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat
    ];
  };

  virtualisation.waydroid.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11";
}
