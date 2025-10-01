{
  description = "A simple NixOS flake";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    oisd = {
      url = "https://big.oisd.nl/domainswild";
      flake = false;
    };
    p2pool = {
      url = "github:jacoMalan1/nixos-p2pool-module";
      inputs.nixpkgs.follows = "nixpkgs";          
      };
    impermanence = {
      url="github:nix-community/impermanence";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, plasma-manager, oisd, p2pool, impermanence, ... }:
    let 
      flakeSettings = {
        username = "vanmanhacks";
        hostname = "nixheim";
        system = "x86_64-linux";
	      email = "vanmanhacks@proton.me";
      };
    
    in { 
      nixosConfigurations.${flakeSettings.hostname} = nixpkgs.lib.nixosSystem {
	specialArgs = { inherit inputs flakeSettings; };
        modules = [
          ./profile/configuration.nix
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
