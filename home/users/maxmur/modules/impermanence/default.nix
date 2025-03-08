{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.user.impermanence;
in {
  options = {
    module.user.impermanence.enable = mkEnableOption "Enables home impermanence";
  };

  config = mkIf cfg.enable {
    home.persistence = {
      "/persist/home/${username}" = {
        allowOther = true;

        directories = [
          "Code"
          "Desktop"
          "Downloads"
          "Documents"
          "go"
          "Music"
          "Pictures"
          "Public"
          "Templates"
          "Videos"
          "VirtualBox VMs"
          "Trash"
          "Sync"
          ".ansible_inventory"
          ".docker"
          ".emacs.d"
          ".flutter-devtools"
          ".kube"
          ".m2"
          ".mozilla"
          ".librewolf"
          ".thunderbird"
          ".obsidian"
          ".openvpn"
          ".password-store"
          ".themes"
          ".terraform.d"
          ".yandex"
          ".ollama"
          ".config/google-chrome"
          ".config/sops"
          ".config/vesktop"
          ".config/sops-nix"
          ".config/obsidian"
          ".config/Code"
          ".config/dconf"
          ".config/htop"
          ".config/nvim"
          ".config/syncthing"
          ".config/obs-studio"
          ".config/pulse"
          ".config/Thunar"
          ".config/vlc"
          ".local/share/chat.fluffy.fluffychat"
          ".local/share/zoxide"
          ".local/share/fish"
          ".local/share/nix"
          ".local/share/nvf"
          ".local/share/containers"
          ".local/share/Trash"
          ".local/share/TelegramDesktop"
          ".local/share/keyrings"
          ".local/share/nvim"
          ".local/state"
          ".vscode"
          ".pki"
          ".ssh"
          ".gnupg"
        ];

        files = [
          ".bash_history"
          ".bash_logout"
          ".flutter"
          ".face"
          ".face.icon"
          ".zsh_history"
          ".cache/cliphist/db"
        ];
      };
    };
  };
}
