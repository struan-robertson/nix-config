# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    ./Desktop/hypr/hyprland.nix
    ./Desktop/waybar/waybar.nix

    ./fish.nix

    ./Emacs/emacs.nix

  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      (import ../Overlays/home-manager/zotero.nix)

      (final: prev: {
        papirus-nord = prev.papirus-nord.override {
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
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    tofi
    zotero
    zathura

    # For Thunar Archvives
    mate.engrampa
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-nord;
      name = "Papirus-Dark";
    };
    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  xdg.configFile."tofi/config".text = ''
    width = 200%
    height = 200%
    border-width = 0
    outline-width = 0
    padding-left = 97%
    padding-top = 75%
    result-spacing = 25
    num-results = 9
    font = /home/struan/Sync/bin/InterNerdFont-Regular.otf
    background-color = #000A
    text-color = #ECEFF4
    selection-color = #5E81AC
    prompt-text ="󰑮 "
  '';

  xdg.mime.enable = true;
  xdg.systemDirs.data =
    [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 22;
  };

  home.sessionVariables = { SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent"; };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Struan Robertson";
    userEmail = "contact@struanrobertson.co.uk";
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        color_scheme = 'nord',
        font = wezterm.font 'FiraCode Nerd Font',
        hide_tab_bar_if_only_one_tab = true,
        window_background_opacity = 0.4,
      }
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.firefox.enable = true;

  services = { ssh-agent.enable = true; };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
