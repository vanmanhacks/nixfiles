{ ... }:

{
  networking.hosts = {
    "192.168.40.100" = [ "macnix" ];
    "100.116.141.18" = [ "macnix-tailscale" ];
    "192.168.40.231" = [ "hpnix" ];
    "23.94.184.152" = [ "bbvm" ];
  };
}
