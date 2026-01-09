{ pkgs, flakeSettings, ... }:

{

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-rs
  ];

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = ("/home/" + (flakeSettings.username) + "/.steam/root/compatibilitytools.d");
  };

}


