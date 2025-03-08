{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.cpu-autofreq;
in {
  options = {
    module.services.cpu-autofreq.enable = mkEnableOption "Enable cpu-autofreq";
  };

  config = mkIf cfg.enable {
    services.auto-cpufreq = {
      enable = true;

      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };

        battery = {
          governor = "conservative";
          # governor = "powersave";
          energy_performance_preference = "power";
          epp = "power";
          energy-performance-preference = "power";
          turbo = "never";
          scaling_max_freq = 2000000;
        };
      };
    };
  };
}
