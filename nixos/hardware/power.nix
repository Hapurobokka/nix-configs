{ pkgs, ... }:
{
  services = {
    # power-profiles-daemon y tlp son mutuamente excluyentes
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

        # Limita la carga al 80% para preservar la batería
        # Cambia a 0 para deshabilitar el límite
        STOP_CHARGE_THRESH_BAT0 = 1;
      };
    };
    thermald.enable = false;
  };

  # Descomentar si quieres el kernel zen (mejor latencia para gaming/audio)
  # boot.kernelPackages = pkgs.linuxPackages_zen;
}
