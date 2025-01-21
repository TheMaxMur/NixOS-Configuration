{
  config,
  ...
}:

{
  module = {
    locales.enable = true;
    network.enable = true;
    security.enable = true;
    timedate.enable = true;
    users.enable = true;

    programs = {
      gnupg.enable = true;
      hm.enable = true;
      nh.enable = true;
      mtr.enable = true;
      zsh.enable = true;
      fish.enable = true;
      dconf.enable = true;
      systemPackages.enable = true;
    };
    services = {
      unbound.enable = true;

      adguard-home = {
        enable = true;
        httpAddress = "192.168.1.8";

        bindHosts = [
          "192.168.1.8"
          "127.0.0.1"
        ];

        dnsRewrites = [
          {
            domain = "gitlab.maxmur.info";
            anwser = "192.168.1.8";
          }
        ];
      };

    };
  };
}
