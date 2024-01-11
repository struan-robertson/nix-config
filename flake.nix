{
  description = "NixOS Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-custom.url = "github:struan-robertson/nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { nixpkgs,
              nixpkgs-unstable,
              nixpkgs-custom,
              home-manager, 
              ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nix = nixpkgs.lib.nixosSystem rec {

        system = "x86_64-linux";

        specialArgs = {

          inherit inputs;

          pkgs-unstable = import nixpkgs-unstable {
            system = system;
            config.allowUnfree = true;
          };

          pkgs-custom = import nixpkgs-custom {
            system = system;
            config.allowUnfree = true;
          };

        };

        modules = [ 
          ./nixos/configuration.nix 
        ];
      };
    };

    # home-manager configuration entrypoint
    # Available through 'home-manager --flake .#struan@nix'
    homeConfigurations = {
      "struan@nix" = home-manager.lib.homeManagerConfiguration {

        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs;

          pkgs-unstable = import nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };

          pkgs-custom = import nixpkgs-custom {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };

        };

        modules = [ 
          ./home-manager/home.nix 
        ];
      };
    };
  };
}
