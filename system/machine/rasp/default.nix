_:

{
  imports = [
    ../../modules
    ./modules/temp-control
    ./modules/hardware
    ./modules/nginx
  ];

  module = {
    locales.enable = true;
    network.enable = true;
    security.enable = true;
    timedate.enable = true;
    users.enable = true;
    pihole.enable = true;
    
    programs.systemPackages.enable = true;
  };
}

