# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, pkgs-unstable, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    ./Desktop/hypr/hyprland.nix
    ./Desktop/eww/eww.nix
    ./Desktop/theme.nix
    ./Desktop/tofi.nix
    ./Desktop/xdg.nix

    ./Terminal/fish.nix
    ./Terminal/wezterm.nix
    ./Terminal/ipython.nix

    ./Emacs/emacs.nix

    # ./Services/ssh-agent.nix

  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      # (import ../Overlays/home-manager/zotero.nix)

      # Not sure of another way to do it, so the overriden unstable package becomes part of pkgs
      (final: prev: {
        papirus-nord = pkgs-unstable.papirus-nord.override {
          accent = "frostblue4";
        };
      })

      # Or define it inline, for example:
      # (final: prev: {
      #   helo = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "struan";
    homeDirectory = "/home/struan";
  };

  home.packages = with pkgs; [
    neofetch
    fzf
    pavucontrol
    gnumake
    cmake
    zotero
    sioyek
    libreoffice
    powertop
    imv
    kitty

    radeontop
    lm_sensors
    nvtop
    killall

    # For Thunar Archvives
    mate.engrampa

    pkgs-unstable.yazi
  ];

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    userName = "Struan Robertson";
    userEmail = "contact@struanrobertson.co.uk";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
