{ flakeSettings, ... }:

{
  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    # extraDependencyGroups = [ "messaging" ];
    # 
    # stateDir = "/home/${flakeSettings.username}/.hermes/";
    # workingDirectory = "/home/${flakeSettings.username}/Projects/HermesAgent/agent/workspace/";

    # environmentFiles = [ "/home/vanmanhacks/Projects/HermesAgent/agent/hermes_env" ];
    # configFile = "/home/vanmanhacks/Projects/HermesAgent/agent/config.yaml";
  };
}
