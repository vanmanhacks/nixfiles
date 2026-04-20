{ pkgs, flakeSettings, ... }:

{

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.steam.protontricks.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  environment.systemPackages = with pkgs; [
    steam-run
    mangohud
    protonup-rs
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  programs.gamemode.enable = true;

  # environment.sessionVariables = {
  #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = ("/home/" + (flakeSettings.username) + "/.steam/root/compatibilitytools.d");
  # };

}


