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
    ./Desktop/waybar/waybar.nix

    ./Terminal/fish.nix
    ./Terminal/wezterm.nix

    ./Emacs/emacs.nix

    ./Services/ssh-agent.nix

  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      (import ../Overlays/home-manager/zotero.nix)

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
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    tofi
    zotero
    sioyek
    libreoffice
    powertop

    # For Thunar Archvives
    mate.engrampa
  ];

  programs.firefox.enable = true;

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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "sioyek.desktop" "firefox.desktop" ];
    };
  };


  home.sessionVariables = { SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent"; };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Struan Robertson";
    userEmail = "contact@struanrobertson.co.uk";
  };


  services = { ssh-agent.enable = true; };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
