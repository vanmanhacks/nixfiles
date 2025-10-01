{
  config,
  pkgs,
  lib,
  flakeSettings,
  ...
}: 
let
  inherit (lib) mkIf;
  cfg = config.custom.security.usbguard;
in {
  options.custom.security.usbguard = {
    enable = lib.mkEnableOption "usbguard";
  };

  config = mkIf cfg.enable {
    services.usbguard = {
      enable = true;
      IPCAllowedUsers = ["root" "${flakeSettings.username}"];
      presentDevicePolicy = "allow";
        #rules = ''
        # allow `only` devices with mass storage interfaces (USB Mass Storage)
        #allow with-interface equals { 08:*:* }
        # allow mice and keyboards
        # allow with-interface equals { 03:*:* }

        # Reject devices with suspicious combination of interfaces
        #reject with-interface all-of { 08:*:* 03:00:* }
        #reject with-interface all-of { 08:*:* 03:01:* }
        #reject with-interface all-of { 08:*:* e0:*:* }
        #reject with-interface all-of { 08:*:* 02:*:* }
      #'';
      ruleFile = "/var/lib/usbguard/usbguard-rules.conf";
    };

    environment.systemPackages = [pkgs.usbguard];
  };
}

