{ config, ... }:
{
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
  #       sync.enable = false;
  #     };
  #   };
  # };
  services.xserver.videoDrivers = [ "nvidia" ];
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
}
