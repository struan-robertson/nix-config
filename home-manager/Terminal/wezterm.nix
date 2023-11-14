{ config, lib, pkgs-unstable, ... }:

{
  programs.wezterm = {
    enable = true;
    package = pkgs-unstable.wezterm;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        color_scheme = 'nord',
        font = wezterm.font 'FiraCode Nerd Font',
        hide_tab_bar_if_only_one_tab = true,
        window_background_opacity = 0.9,
      }
    '';
  };
}
