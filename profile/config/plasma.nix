{ pkgs, flakeSettings, ... }:

{
        programs.plasma = {
                enable = true;
                kwin.virtualDesktops.number = 4;
                workspace = {
                  lookAndFeel = "Nordic-bluish";
                };
                panels = [
                  {
                    location = "top";
                  }
                ];
                hotkeys.commands = {
                        "launch-term" = {
                                name = "Launch Terminal";
                                key = "Meta+Return";
                                command = "alacritty";
                        };
                        "launch-browser" = {
                                name = "Launch Browser";
                                key = "Meta+Shift+Return";
                                command = "brave";
                        };
                        "flameshot-screenshot" = {
                                name = "Take Flamshot Screenshot";
                                key = "Meta+Shift+F";
                                command = ( "flameshot gui --path /home" + ("/" + flakeSettings.username) + "/Library/Pictures/Screenshots" );
                        };
                        "launch-calibre" = {
                                name = "Launch Calibre";
                                key = "Meta+Shift+C";
                                command = "calibre";
                        };
                        "launch-keepass" = {
                                name = "Launch KeePassXC";
                                key = "Meta+Shift+K";
                                command = "keepassxc";
                        };
                        "launch-obsidian" = {
                                name = "Launch Obsidian";
                                key = "Meta+Shift+O";
                                command = "obsidian";
                        };
                };
                shortcuts.kwin = {
                        #"Close Window" = "Meta+Q";
                        #"Maximize Window" = "Meta+F";
                        #"Minimize Window" = "Meta+H";
                        "Switch to Desktop 1" = "Meta+1";
                        "Switch to Desktop 2" = "Meta+2";
                        "Switch to Desktop 3" = "Meta+3";
                        "Switch to Desktop 4" = "Meta+4";
                        "Window to Desktop 1" = "Meta+!";
                        "Window to Desktop 2" = "Meta+@";
                        "Window to Desktop 3" = "Meta+#";
                        "Window to Desktop 4" = "Meta+$";
                };
        };
}
