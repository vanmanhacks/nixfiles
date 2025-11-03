{ config, ... }:

{
  services.firefly-iii = {
    enable = true;
    enableNginx = true;
    dataDir = "/var/firefly-iii/";
    settings.APP_KEY_FILE = "/var/firefly-iii/appkey.txt";
    # settings.APP_URL = "http://app:8083";
  };

  services.firefly-iii-data-importer = {
    enable = true;
    settings = {
      FIREFLY_III_ACCESS_TOKEN = "/var/firefly-iii/accesstoken.txt";
    };
    # enableNginx = true;
  };

  services.nginx.virtualHosts.${config.services.firefly-iii.virtualHost} = {
    listen = [{
      addr = "127.0.0.1";
      port = 8083;
    }];
  };

  # services.nginx.virtualHosts.${config.services.firefly-iii-data-importer.virtualHost} = {
  #   listen = [{
  #     addr = "0.0.0.0";
  #     port = 8083;
  #   }];
  # };
}
