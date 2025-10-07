{ pkgs, ... }:

{

  services.logrotate.enable = true;
  services.logrotate.settings = {

    # --- Audit Log Rotation ---
    "/var/log/audit/audit.log" = {
      size = "50M";

      # Retention: Keep 12 rotated log files (e.g., audit.log.1, audit.log.2, ...).
      rotate = 5;

      # Compress old log files to save space.
      compress = true;

      # If the log file doesn't exist, don't produce an error.
      missingok = true;

      # Don't rotate the log if it's empty.
      notifempty = true;

      # CRITICAL for auditd: Copy the log file and truncate the original.
      # This ensures the auditd service never loses its file handle and
      # continues to write to the correct file without needing to be restarted.
      copytruncate = true;

      # After rotation, create a new empty log file with secure permissions
      # (read/write for root only).
      create = "0600 root root";

      postrotate = ''
        ${pkgs.procps}/bin/kill -HUP $(cat /run/auditd.pid)
      '';
    };

    # --- General System Log Rotation ---
    "/var/log/*.log" = {
      size = "50M";
      rotate = 4;
      compress = true;
      missingok = true;
      notifempty = true;
      su = "root root";
    };

    "/var/log/**/*.log" = {
      size = "50M";
      rotate = 4;
      compress = true;
      missingok = true;
      notifempty = true;
      su = "root root";
    };

    "/var/log/mullvad-vpn/*.log" = {
      monthly = true;
      rotate = 1;
      compress = true;
      missingok = true;
      create = "0600 root root";
    };

    "/var/log/libvirt/*.log" = {
      monthly = true;
      rotate = 1;
      compress = true;
      missingok = true;
      create = "0600 root root";
    };

    # --- Login Record Rotation ---
    "/var/log/btmp" = {
      monthly = true;
      rotate = 1;
      compress = true;
      missingok = true;
      create = "0600 root utmp";
    };

    "/var/log/wtmp" = {
      monthly = true;
      rotate = 1;
      compress = true;
      missingok = true;
      create = "0664 root utmp";
    };
  };

  services.journald.storage = "persistent";
  services.journald.extraConfig = ''
    SystemMaxUse=250M
  '';
}
