{
  description = "NixOS Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Emacs Overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";

  };

  outputs = { nixpkgs, 
              home-manager, 
              hyprland, 
              nix-doom-emacs, 
              emacs-overlay,
              ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nixlaptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config

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
        extraSpecialArgs = { inherit inputs; };
        modules = [ 
          ./home-manager/home.nix 
        ];
      };
    };
  };
}
