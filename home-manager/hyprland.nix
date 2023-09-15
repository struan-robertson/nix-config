
{
  wayland.windowManager.hyprland.enable = true;


 wayland.windowManager.hyprland.extraConfig = ''
   $mod = SUPER

   bind = $mod, return, exec, wezterm
   bind = $mod, C, exec, firefox

 '';
}
