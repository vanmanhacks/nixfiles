{ pkgs, ... }: {
  services.cron = {
    enable = true;
    # messages.enable = true;
    systemCronJobs = [
      # Every monday at 9:00 AM, run clamscan as root and append output to a log file
      "0 9 * * 1 root ${pkgs.clamav}/bin/clamscan -or /persist >> /var/log/clamscan.log"
      # Every monday at 9:15 AM, run aide as root and append output to a log file
      "0 9 * * 1 root ${pkgs.aide}/bin/aide --check >> /var/log/aide.log"
    ];
  };
}

