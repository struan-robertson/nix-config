{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    theme = "Nord";
    font = {
      name = "FiraCode Nerd Font";
      size = 8;
    };


  };
}
