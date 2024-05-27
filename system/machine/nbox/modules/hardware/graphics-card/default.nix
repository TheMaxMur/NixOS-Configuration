{ pkgs
, ...
}:

{
  # Graphics card settings
  nixpkgs.overlays = [
    (import ../../../../../overlays/vaapiIntel)
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      mesa
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}

