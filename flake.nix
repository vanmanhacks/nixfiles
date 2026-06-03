{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #p2pool = {
    #url = "github:jacoMalan1/nixos-p2pool-module";
    #inputs.nixpkgs.follows = "nixpkgs";          
    #};
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      # follows = "nixpkgs-unstable";
    };
    hermes-agent.url = "github:NousResearch/hermes-agent";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nvf, plasma-manager, impermanence, lanzaboote, hermes-agent, ... }:
    let
      flakeSettings = {
        username = "vanmanhacks";
        hostname = "nixheim";
        system = "x86_64-linux";
        email = "vanmanhacks@proton.me";
      };
      unstablePkgs = import nixpkgs-unstable {
        system = flakeSettings.system;
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "caido-cli"
          "caido-desktop"
          "payloadsallthethings"
          "mat2"
        ];
      };

    in
    {
      nixosConfigurations.${flakeSettings.hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs flakeSettings;
          unstable = unstablePkgs;
        };
        modules = [
          ({ unstable, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                caido-cli-unstable = unstable.caido-cli;
                caido-desktop-unstable = unstable.caido-desktop;
                payloadsallthethings-unstable = unstable.payloadsallthethings;
                mat2-unstable = unstable.mat2;
              })
            ];
          })
          ./profile/configuration.nix
          hermes-agent.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          impermanence.nixosModules.impermanence
          nvf.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "hm-backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.${flakeSettings.username} = import ./profile/home.nix;
            home-manager.extraSpecialArgs = { inherit flakeSettings; };
          }
        ];
      };
    };
}
