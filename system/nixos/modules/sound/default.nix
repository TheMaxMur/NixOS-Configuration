{
  lib,
  config,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.sound;
in
{
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
    };
  };
}
