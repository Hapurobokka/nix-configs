# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
let
  checkBatteryScript = pkgs.pkgs.writers.writeNuBin "start" /*nu*/ ''
    let low_threshold = 20
    let full_battery = 99
    let battery_info = (^${pkgs.acpi}/bin/acpi -b) | ^grep -oP "[0-9]+(?=%)" | into int

    if ( $battery_info <= $low_threshold )  {
      notify-send -u critical "💖 ¡Alerta de Batería Baja, maestro! 💖" $"¡Kyaa! Tu batería está en ($battery_info)% o menos. ¡Es hora de recargar, onegai! 🙏🔋"
    } else if $battery_info >= $full_battery {
      notify-send "🎉 ¡Kyaa! ¡Bateria Completa, maestro! 🎉" "¡Arigato! Tu laptop esta al 100%. ¡Lista para la aventura, nya! 🌟💖"
    }
  '';
in
{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.power-profiles-daemon.enable = false;

  systemd.timers.battery-check = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "10sec";
      OnUnitInactiveSec = "1min";
    };
  };

  systemd.services.battery-check = {
    serviceConfig = {
      Description = ''Muerte'';
      Wants = "graphical-session.target";
      After = "graphical-session.target";
      Type = "oneshot";
      ExecStart = "${checkBatteryScript}/bin/start";
    };
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  services.flatpak.enable = true;

  programs.appimage.enable = true;

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

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_MX.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  security.pam.services."hapu".kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
        Theme = {
          EnableAvatars = true;
        };
      };
    };
  };

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
    NIXOS_OZONE_WL = 1;
    NH_FLAKE = "/home/hapu/nix-configs";
    EDITOR = "nvim";
    XDG_PICTURES_DIR = "~/Imágenes";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # hardware = {
  #   graphics.enable = true;
  #   nvidia = {
  #     modesetting.enable = true;
  #     package = config.boot.kernelPackages.nvidiaPackages.stable;
  #     open = true;
  #     nvidiaSettings = true;
  #     prime = {
  #       intelBusId = "PCI:0:2:0";
  #       nvidiaBusId = "PCI:1:0:0";
  #     };
  #   };
  # };

  boot.blacklistedKernelModules = [ "nouveau" ];

  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # services.pulseaudio.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hapu = {
    isNormalUser = true;
    description = "Hapurobokka";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      waybar
      eww
      kdePackages.partitionmanager
      ghostty
    #  thunderbird
    ];
    shell = pkgs.nushell;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    dunst
    libnotify
    hyprpaper
    kitty
    rofi-wayland
    neovim
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    kdePackages.xdg-desktop-portal-kde
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
