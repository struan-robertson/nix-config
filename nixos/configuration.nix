{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # Import hardware configuration
    # Note that this has been modified from auto generated version
    ./Device/hardware-configuration.nix
    ./Device/graphics.nix
    ./Device/networking.nix
    ./Device/security.nix
    ./Device/sound.nix
    ./Device/bluetooth.nix
    ./Device/openrgb.nix

    ./System/fonts.nix
    ./System/environment.nix

    ./Applications/thunar.nix
    ./Applications/syncthing.nix
    ./Applications/podman.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })

    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;

    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
      config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      trusted-users = [ "struan" ];

      # substituters =
      #   [ "https://hyprland.cachix.org" "https://nix-community.cachix.org" ];

      # trusted-public-keys = [
      #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    nnn
    gitui
    ripgrep
    fd
    bat
    wl-clipboard
    htop
    unzip
    poppler_utils

    gcc
    clang

    # Fish plugins
    fishPlugins.pure
    fishPlugins.puffer
    fishPlugins.pisces

    papirus-icon-theme
  ];

  # Enable fish shell for all users
  programs.fish.enable = true;

  users.users.struan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  users.defaultUserShell = pkgs.fish;

  time.timeZone = "Europe/London";

  services.tailscale.enable = true;

  # Dont need root to access android devices
  services.udev.packages = with pkgs; [ android-udev-rules ];

  # Hyprland
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # Enable flatpak
  services.flatpak.enable = true;

  programs.kdeconnect.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  services.printing.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  # Should be the same on all systems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
