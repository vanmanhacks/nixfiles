{ config, pkgs, lib, flakeSettings, ... }:

{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    extraPackages = [ pkgs.sddm-sugar-dark ];
    theme = "sugar-dark";
  };
  
  environment.systemPackages = [
    pkgs.sddm-sugar-dark
  ];
}
