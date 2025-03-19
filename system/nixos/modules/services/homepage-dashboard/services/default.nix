{
  # Icons - https://github.com/walkxcode/dashboard-icons/tree/main/svg
  services.homepage-dashboard.services = [
    {
      "User" = [
        {
          "Vaultwarden" = {
            description = "Password manager";
            href = "https://vaultwarden.maxmur.info";
            icon = "vaultwarden.svg";
          };
        }
      ];
    }
    {
      "Services" = [
        {
          "AdGuard Home" = {
            description = "DNS manager";
            href = "https://dns.maxmur.info";
            icon = "adguard-home.svg";
          };
        }
        {
          "Forgejo" = {
            description = "Local git manager";
            href = "https://git.maxmur.info";
            icon = "forgejo.svg";
          };
        }
        {
          "Netbird" = {
            description = "VPN access to home network";
            href = "https://netbird.ext.maxmur.info";
            icon = "netbird.svg";
          };
        }
        {
          "Keycloak" = {
            description = "IDM for manage users";
            href = "https://auth.ext.maxmur.info";
            icon = "keycloak.svg";
          };
        }
        {
          "PrivateBin" = {
            description = "Private pastebin";
            href = "https://paste.ext.maxmur.info";
            icon = "hastypaste.svg";
          };
        }
        {
          "Proxmox" = {
            description = "Homelab hypervisor";
            href = "https://proxmox.maxmur.info";
            icon = "proxmox.svg";
          };
        }
      ];
    }
  ];
}
