{ inputs, pkgs, ... }:
{

  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hyprland.conf;

  home.packages = with pkgs; [
    swaybg
    wob
    mako
    pamixer

    wluma
    brillo
  ];


}
