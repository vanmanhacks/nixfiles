{ config, ... }:
{
  services.tailscale.enable = true;
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" "tun0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
  services.resolved.enable = true;
  services.resolved.settings.Resolve.LLMNR = "no";
}
