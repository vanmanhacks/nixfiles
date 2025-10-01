{
  systemd.services.cups.serviceConfig = {
    NoNewPrivileges = true;
    ProtectSystem = "full";
    ProtectHome = true;
    ProtectKernelModules = true;
    ProtectKernelTunables = true; 
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    ProtectHostname = true;
    ProtectClock = true;
    ProtectProc = "invisible";
    RestrictRealtime = true;
    RestrictNamespaces = true;
    RestrictSUIDSGID = true;
    RestrictAddressFamilies = [ 
      "AF_UNIX" 
      "AF_NETLINK"
      "AF_INET"
      "AF_INET6"
      "AF_PACKET"
    ];

    MemoryDenyWriteExecute = true;
    SystemCallFilter = [
      "~@clock"
      "~@reboot"
      "~@debug"
      "~@module"
      "~@swap"
      "~@obsolete" 
      "~@cpu-emulation" 
    ];
    SystemCallArchitectures = "native";
    LockPersonality= true; 
  };
}
