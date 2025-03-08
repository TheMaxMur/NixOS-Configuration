{
  pkgs,
  lib,
  config,
  isWorkstation,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib) optionals;

  cfg = config.module.programs.systemPackages;
in {
  options = {
    module.programs.systemPackages.enable = mkEnableOption "Enable System Software";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.iosevka
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
