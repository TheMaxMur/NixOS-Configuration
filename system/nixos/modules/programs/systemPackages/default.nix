{
  pkgs,
  lib,
  config,
  stateVersion,
  isWorkstation,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib) optionals;

  cfg = config.module.programs.systemPackages;

  iosevkaPackage =
    if stateVersion == "24.11"
    then pkgs.nerdfonts.override {fonts = ["Iosevka"];}
    else pkgs.nerd-fonts.iosevka;
  jbPackage =
    if stateVersion == "24.11"
    then pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];}
    else pkgs.nerd-fonts.iosevka;
in {
  options = {
    module.programs.systemPackages.enable = mkEnableOption "Enable System Software";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      iosevkaPackage
      jbPackage
      corefonts
    ];

    environment.systemPackages = with pkgs;
      [
        # Utils
        git
        nvd
        nix-output-monitor
        curl
        wget
        tree
        file
        zip
        unzip
        killall
        jq

        # Hardware utils
        glxinfo
        pciutils
        usbutils
        powertop
        lm_sensors
        strace
        ltrace
        lsof
        sysstat
        cpufetch
        sbctl

        # Network
        inetutils
        wireguard-tools
        dig
        nmap
        dnsutils
        iperf3
        mtr
        ipcalc
        cacert
      ]
      ++ optionals isWorkstation [
        # Themes
        tela-circle-icon-theme

        # Hardware
        microcodeIntel
        libGL

        # Hardware utils
        libva-utils
        intel-gpu-tools
        fwupd
        fwupd-efi

        # Utils
        dconf-editor
      ];
  };
}
