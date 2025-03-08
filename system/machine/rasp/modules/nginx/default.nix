_: {
  services.nginx = {
    enable = true;

    streamConfig = ''
      resolver 192.168.1.8;

      map $ssl_preread_server_name $internalip {
              wiki.maxmur.info      10.20.0.5;
              gitlab.maxmur.info      10.20.0.5;
              grafana.maxmur.info      10.20.0.5;
      }

      server {
        listen 443;
        ssl_preread on;
        proxy_connect_timeout 5s;
        proxy_pass $internalip:443;
      }

      server {
        listen 4224;
        ssl_preread on;
        proxy_connect_timeout 5s;
        proxy_pass 10.20.0.5:4224;
      }

      server {
        listen 8384;
        ssl_preread on;
        proxy_connect_timeout 5s;
        proxy_pass 10.20.0.5:8384;
      }
    '';
  };
}
