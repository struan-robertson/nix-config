{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    theme = "Nord";
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };

    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = "no";
      window_padding_width = "4 8";
    };

  };
}
