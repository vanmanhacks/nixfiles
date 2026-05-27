{ pkgs, lib, flakeSettings, ... }:

#assert lib.asserts.assertOneOf "storageDriver" storageDriver [
#  null
#  "aufs"
#  "btrfs"
#  "devicemapper"
#  "overlay"
#  "overlay2"
#  "zfs"
#];

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "btrfs";
    autoPrune.enable = true;
    daemon.settings = {
      experimental = true;
      dns = [ "9.9.9.9" ];
    };
  };

  users.users.${flakeSettings.username}.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
    docker-buildx
  ];
}
