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
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
      config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      trusted-users = [ "struan" ];

      substituters =
        [ "https://hyprland.cachix.org" "https://nix-community.cachix.org" ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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

  security.pam.services.swaylock.text = ''
    auth include login
  '';

  services.logind = {
    killUserProcesses = true;
  };

  services.udev = {
    enable = true;
    packages = [
      pkgs.brillo
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.firmware = with pkgs; [
    sof-firmware
    alsa-firmware
  ];

  services.fwupd.enable = true;

  # TODO Remove for desktop profile
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };

  services.fstrim.enable = true;

  programs.fish.enable = true;

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
    font-awesome
    inter
    times-newer-roman
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra

    # Emacs icons
    emacs-all-the-icons-fonts
  ];

  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "FiraCode Nerd Font" ];
      sansSerif = [ "Inter" ];
      serif = [ "Times Newer Roman" ];
    };
  };

  programs.dconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # TODO: when I have a local NAS and dont have to use encryption, make syncthing declarative
  services = {
    syncthing = {
      enable = true;
      user = "struan";
      dataDir = "/home/struan/Sync";
      configDir = "/home/struan/.config/syncthing";
    };
  };

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  # Slight hack to install Doom Emacs on fist system install
  system.userActivationScripts = {
    installDoomEmacs = ''
      if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
           /usr/bin/env git clone --depth=1 --single-branch "https://github.com/doomemacs/doomemacs" "$XDG_CONFIG_HOME/emacs"
           /usr/bin/env git clone "https://github.com/struan-robertson/doom-config" "$XDG_CONFIG_HOME/doom"
      fi

      if [ -d "$HOME/.emacs.d" ]; then
        rm -rf .emacs.d
      fi
    '';
  };

  networking.hostName = "nixlaptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs;
      [
        xdg-desktop-portal-hyprland

      ];
  };

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.swraid.enable = false; # fix warning

  users.users.struan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  users.defaultUserShell = pkgs.fish;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
