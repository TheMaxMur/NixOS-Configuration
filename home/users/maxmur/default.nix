{ self
, lib
, pkgs
, config
, generalModules
, homeModules
, isWorkstation
, wm
, ...
}:

let
  inherit (pkgs.stdenv) isLinux;

  sshModule = "${homeModules}/ssh";
  sshModuleExist = builtins.pathExists sshModule;

  swayEnable = if wm == "sway" then true else false;
  hyprlandEnable = if wm == "hyprland" then true else false;
  wmEnable = config.module.hyprland.enable || config.module.sway.enable;
in {
  imports = [
    "${generalModules}"
    "${homeModules}"
    "${self}/home/users/maxmur/modules"
  ] ++ lib.optional sshModuleExist sshModule;

  nixpkgs.overlays = [  ];

  stylix.targets = {
    vscode.enable = false;
    helix.enable = false;
  };

  module = {
    alacritty.enable  = isWorkstation;
    vscode.enable     = isWorkstation;
    doom-emacs.enable = isWorkstation;
    zathura.enable    = isWorkstation;

    chrome.enable       = isLinux && isWorkstation;
    firefox.enable      = isLinux && isWorkstation;
    foot.enable         = isLinux && isWorkstation;
    ssh.enable          = isLinux && isWorkstation;
    impermanence.enable = isLinux && isWorkstation;
    xdg.enable          = isLinux && isWorkstation;

    hyprland.enable     = hyprlandEnable && isLinux && isWorkstation;
    sway.enable         = swayEnable && isLinux && isWorkstation;

    hypridle.enable  = wmEnable;
    hyprlock.enable  = wmEnable;
    waybar.enable    = wmEnable;
    rofi.enable      = wmEnable;
    swaync.enable    = wmEnable;

    btop.enable           = true;
    eza.enable            = true;
    git.enable            = true;
    fzf.enable            = true;
    htop.enable           = true;
    ripgrep.enable        = true;
    neofetch.enable       = true;
    nvim.enable           = true;
    helix.enable          = true;
    password-store.enable = true;
    zsh.enable            = true;
    fish.enable           = true;
    zoxide.enable         = true;
    yazi.enable           = true;

    users.maxmur.packages = {
      inherit wmEnable;
      enable = true;
    };
  };
}

