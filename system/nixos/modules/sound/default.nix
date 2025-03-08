{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.sound;
in {
  options = {
    module.sound.enable = mkEnableOption "Enables sound in your system";
  };

  config = mkIf cfg.enable {
    # Sound settings
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      extraConfig = {
        pipewire = {
          "92-low-latency" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.allowed-rates" = [
                44100
                48000
                88200
                96000
              ];

              "default.clock.min-quantum" = 512;
              "default.clock.quantum" = 4096;
              "default.clock.max-quantum" = 8192;
            };
          };

          "93-no-resampling" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.allowed-rates" = [
                44100
                48000
                96000
                192000
              ];
            };
          };

          "94-no-upmixing" = {
            "stream.properties" = {
              "channelmix.upmix" = false;
            };
          };
        };
      };
    };
  };
}
