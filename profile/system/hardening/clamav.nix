{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clamav
    aide
  ];

  # services.aide = {
  #   enable = true;
  #   config = {
  #     rules = [
  #       "/persist"
  #     ];
  #   };
  # };
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    updater.interval = "daily"; # Number of database checks per day
    # scanner = {
    # enable = true;
    # interval = "*-*-* 04:00:00";
    # scanDirectories = [
    # "/persist"
    # ];
    # };
  };
}

