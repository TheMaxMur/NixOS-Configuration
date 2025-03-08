{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.chromium;
in {
  options = {
    module.chromium.enable = mkEnableOption "Enables Chromium";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;

      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        "jghecgabfgfdldnmbfkhmffcabddioke" # Volume Master
      ];

      commandLineArgs = [
        # Wayland
        "--ozone-platform=wayland"
        "--ozone-platform-hint=auto"
        # Performance
        "--gtk-version=4"
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-oop-rasterization"
        "--enable-zero-copy"
        "--ignore-gpu-blocklist"
        # Etc
        "--disk-cache=$XDG_RUNTIME_DIR/chromium-cache"
        "--disable-reading-from-canvas"
        "--no-first-run"
        "--disable-wake-on-wifi"
        "--disable-speech-api"
        "--disable-speech-synthesis-api"
        # Use strict extension verification
        "--extension-content-verification=enforce_strict"
        "--extensions-install-verification=enforce_strict"
        # Disable pings
        "--no-pings"
        # Require HTTPS for component updater
        "--component-updater=require_encryption"
        # Disable crash upload
        "--no-crash-upload"
        # don't run things without asking
        "--no-service-autorun"
        # Disable sync
        "--disable-sync"
        # Disable autofill
        "AutofillPaymentCardBenefits"
        "AutofillPaymentCvcStorage"
        "AutofillPaymentCardBenefits"
      ];
    };
  };
}
