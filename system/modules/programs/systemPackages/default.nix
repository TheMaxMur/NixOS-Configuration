{ pkgs
, lib
, config
, isWorkstation
, ...
}:

with lib;

let
  cfg = config.module.programs.systemPackages;
in {
  options = {
    module.programs.systemPackages.enable = mkEnableOption "Enable System Software";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" "UbuntuMono" ]; })
      corefonts
    ];

    environment.systemPackages = with pkgs; [
      # Utils
      git
      home-manager
      nvd
      nix-output-monitor
      curl
      wget
      tree
      file
      zip
      unzip
      killall

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
    ] ++ optionals isWorkstation [
      # Themes
      orchis-theme
      vimix-cursors
      tela-circle-icon-theme
      nordic

      # Hardware
      microcodeIntel
      libGL
      qmk

      # Hardware utils
      libva-utils
      intel-gpu-tools
      fwupd
      fwupd-efi

      # Utils
      gnome.dconf-editor
      grim
    ];
  };
}

