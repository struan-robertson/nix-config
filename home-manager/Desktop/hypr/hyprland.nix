{ inputs, ... }:
{

  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hyprland.conf;

}
