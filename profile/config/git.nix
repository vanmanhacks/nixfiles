{ config, pkgs, flakeSettings, ... }:
# COMMENT
{
  programs.git.enable = true;
  # programs.git.user.name = flakeSettings.username;
  # programs.git.user.email = flakeSettings.email;
}
