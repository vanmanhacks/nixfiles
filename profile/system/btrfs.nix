{ config, pkgs, lib, ... }:  

{ 
  fileSystems = {
    "/" = { 
      device = "none"; 
      fsType = "tmpfs"; 
      options = [ "defaults" "size=2G" "mode=755" ]; 
    };

    "/boot" = { 
      device = "/dev/disk/by-label/NIXBOOT"; 
      fsType = "vfat"; 
      neededForBoot = true; 
    };

    "/nix" = { 
      device = "/dev/disk/by-label/NIXROOT"; 
      fsType = "btrfs"; 
      options = [ "subvol=@nix" "compress=zstd" "noatime" ]; 
      neededForBoot = true; 
    };

    "/persist" = { 
      device = "/dev/disk/by-label/NIXROOT"; 
      fsType = "btrfs"; 
      options = [ "subvol=@persist" "compress=zstd" "noatime" ]; 
      neededForBoot = true; 
    };

    "/persist/home" = { 
      device = "/dev/disk/by-label/NIXROOT"; 
      fsType = "btrfs"; 
      options = [ "subvol=@home" "compress=zstd" "noatime" ]; 
      neededForBoot = true; 
    };

    "/persist/var/log" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "subvol=@log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };
  };
}
