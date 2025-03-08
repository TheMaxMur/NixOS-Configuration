_: {
  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist" = {
      hideMounts = true;

      directories = [
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        "/etc/wireguard"
        "/etc/secureboot"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/log"
        "/var/lib/docker"
        "/var/lib/netbird"
        "/var/lib/containers"
        "/var/lib/qemu"
        "/var/lib/private"
        "/var/db"
        "/var/lib/NetworkManager"
        "/var/lib/chrony"
        "/var/lib/iwd"
        "/var/lib/libvirt"
        "/var/lib/systemd"
        "/var/lib/private/yggdrasil"
      ];

      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
  };
}
