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
 
      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
      inputs.emacs-overlay.overlay
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  #wayland.windowManager.hyprland.enable = true;

  home = {
    username = "struan";
    homeDirectory = "/home/struan";
  };

  home.packages = with pkgs; [ 
    neofetch
    fzf
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 22;
  };

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

  programs.helix = {
    enable = true;
    settings.theme = "nord";
  };
  

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
