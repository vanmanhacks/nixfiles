{ flakeSettings, ... }:

{

  programs.alacritty = {
    enable = true;
    #                shell.program = ${zsh}/bin/zsh;
    settings = {
      window = {
        opacity = 0.5;
        blur = true;
        title = "${flakeSettings.username}@${flakeSettings.hostname}";
      };
    };
  };

}
