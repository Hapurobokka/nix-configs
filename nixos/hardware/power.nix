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

        # Activa el modo Long_Life de Lenovo (el límite exacto depende del hardware).
        # Cambia a 0 para desactivar el modo de conservación.
        STOP_CHARGE_THRESH_BAT1 = 1;
      };
    };
    thermald.enable = false;
  };

  # Descomentar si quieres el kernel zen (mejor latencia para gaming/audio)
  # boot.kernelPackages = pkgs.linuxPackages_zen;
}
