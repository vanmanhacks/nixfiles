{ config, pkgs, inputs, flakeSettings, ...}:

{
  users.mutableUsers = false;
  users.users.root.hashedPasswordFile = "/persist/passwords/root";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${flakeSettings.username} = {
    isNormalUser = true;
    description = flakeSettings.username;
    extraGroups = [ "docker" "networkmanager" "wheel" "libvirtd" ];
    hashedPasswordFile = "/persist/passwords/${flakeSettings.username}";
  };

  # Enable automatic login for the user.
  #services.displayManager.autoLogin.enable = true;
  #services.displayManager.autoLogin.user = flakeSettings.username;

}
