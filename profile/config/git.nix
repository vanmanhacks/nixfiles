{ config, pkgs, flakeSettings, ... }:
# COMMENT
{
  programs.git.enable = true;
  programs.git.settings.user.name = flakeSettings.username;
  programs.git.settings.user.email = flakeSettings.email;
}
