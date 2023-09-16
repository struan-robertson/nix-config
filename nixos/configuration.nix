# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      trusted-users = [ "struan" ];

      substituters = [
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
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

    # Fish plugins
    fishPlugins.pure
    fishPlugins.puffer
    fishPlugins.pisces
  ];

  programs.fish.enable = true; 

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  networking.hostName = "nixlaptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  services.printing.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.root = {
    device = "/dev/disk/by-uuid/cca4afd7-4b96-455c-aaee-d1f6446fee4e";
    preLVM = true;
    allowDiscards = true;
  };
  boot.swraid.enable = false; # fix warning

  users.users.struan = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  users.defaultUserShell = pkgs.fish;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
