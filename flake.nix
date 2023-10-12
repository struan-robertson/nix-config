{
  description = "NixOS Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";


  };

  outputs = { nixpkgs,
              nixpkgs-unstable,
              home-manager, 
              hyprland, 
              ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nixlaptop = nixpkgs.lib.nixosSystem rec {

        system = "x86_64-linux";

        specialArgs = {

          inherit inputs;

          pkgs-unstable = import nixpkgs-unstable {
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
    # Available through 'home-manager --flake .#struan@nixlaptop'
    homeConfigurations = {
      "struan@nixlaptop" = home-manager.lib.homeManagerConfiguration {

        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs;

          pkgs-unstable = import nixpkgs-unstable {
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
