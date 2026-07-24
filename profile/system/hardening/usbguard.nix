{ config
, pkgs
, lib
, flakeSettings
, ...
}:
let
  inherit (lib) mkIf;
  cfg = config.custom.security.usbguard;
in
{
  options.custom.security.usbguard = {
    enable = lib.mkEnableOption "usbguard";
  };

  config = mkIf cfg.enable {
    services.usbguard = {
      enable = true;
      IPCAllowedUsers = [ "root" "${flakeSettings.username}" ];
      presentDevicePolicy = "allow";
      rules = ''
        allow id 1d6b:0002 name "xHCI Host Controller" hash "d3YN7OD60Ggqc9hClW0/al6tlFEshidDnQKzZRRk410=" parent-hash "Y1kBdG1uWQr5CjULQs7uh2F6pHgFb6VDHcWLk83v+tE=" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 name "xHCI Host Controller" hash "4Q3Ski/Lqi8RbTFr10zFlIpagY9AKVMszyzBQJVKE+c=" parent-hash "Y1kBdG1uWQr5CjULQs7uh2F6pHgFb6VDHcWLk83v+tE=" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0002 name "xHCI Host Controller" hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" parent-hash "rV9bfLq7c2eA4tYjVjwO4bxhm+y6GgZpl9J60L0fBkY=" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 name "xHCI Host Controller" hash "prM+Jby/bFHCn2lNjQdAMbgc6tse3xVx+hZwjOPHSdQ=" parent-hash "rV9bfLq7c2eA4tYjVjwO4bxhm+y6GgZpl9J60L0fBkY=" with-interface 09:00:00 with-connect-type ""
        allow id 05e3:0608 name "USB2.0 Hub" hash "W6l+xvpLKIN6p2T3tTOGGy7Qm+zPESG43Fox/qV9OCE=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" via-port "3-4" with-interface 09:00:00 with-connect-type "hotplug"
        allow id 0c45:636b name "USB 2.0 Camera" hash "TKkEeuYH3e2wzeKkxiNfQAST0dWL1+Sq1Te//SzHfqw=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 0e:01:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 } with-connect-type "hardwired"
        allow id 27c6:6584 name "Goodix USB2.0 MISC" hash "eTmCVico8h8DCCKUA0V6FS4W1XiBxul9B0NEkfh6bVQ=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface ff:00:00 with-connect-type "hardwired"
        allow id 1532:008a name "Razer Viper Mini" hash "gycRexMyR2eGopBOXcvPU/f0DxxE7h6u9RS9aUViBXM=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" via-port "3-7" with-interface { 03:01:02 03:00:01 03:00:01 } with-connect-type "hotplug"
        allow id 04e8:4001 name "PSSD T7" hash "m7rjMn8n1aRvqnO2uqrYm0OzBEPHacTlorF9dSRPc5I=" parent-hash "prM+Jby/bFHCn2lNjQdAMbgc6tse3xVx+hZwjOPHSdQ=" with-interface { 08:06:50 08:06:62 } with-connect-type "hotplug"
        allow id 8087:0032 name "" hash "ClCa9utWpkfhSL14jLzpmilrrbre65+44YYBM4ysI/4=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" via-port "3-10" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "hardwired"
        allow id 05e3:0761 name "USB Storage" hash "G4fukafF7fGi5ZhNRv9HT21PxVctIpwN8PiQHpdSlMQ=" parent-hash "W6l+xvpLKIN6p2T3tTOGGy7Qm+zPESG43Fox/qV9OCE=" via-port "3-4.1" with-interface 08:06:50 with-connect-type "unknown"
        allow id 0781:55dd name "Extreme 55DD" hash "de7gZwT4Y2PpIblVNvH+pmpz6pwHQ2c8DiupBJ3oVl4=" parent-hash "W6l+xvpLKIN6p2T3tTOGGy7Qm+zPESG43Fox/qV9OCE=" with-interface { 08:06:50 08:06:62 } with-connect-type "unknown"
        allow id 258a:002a name "Gaming KB " hash "EwPjF8W14vm7hrvUnNIABDSecPjcV26UcuCD++z4cDI=" parent-hash "W6l+xvpLKIN6p2T3tTOGGy7Qm+zPESG43Fox/qV9OCE=" via-port "3-4.2" with-interface { 03:01:01 03:00:00 } with-connect-type "unknown"
      '';
    };

    environment.systemPackages = [ pkgs.usbguard ];
  };
}
