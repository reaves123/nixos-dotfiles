{
  description = "andis Nix Config :)";

  inputs = {
    # Stable for servers
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # Unstable for desktop/development
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, home-manager-stable, home-manager-unstable, ... }: {
    nixosConfigurations = {
      
      # Desktop with unstable packages
      desktop = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
          ./common/base.nix
          home-manager-unstable.nixosModules.home-manager
          {
            # Make unstable packages available
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      # Business server with stable (reliability)
      business-server = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/business-server/configuration.nix
          ./common/base.nix
          ./common/server.nix
          ./common/web-server.nix
          home-manager-stable.nixosModules.home-manager
        ];
      };

      # Private server with stable
      private-server = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/private-server/configuration.nix
          ./common/base.nix
          ./common/server.nix
          home-manager-stable.nixosModules.home-manager
        ];
      };
    };
  };
}
