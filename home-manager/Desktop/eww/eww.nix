{ config, lib, pkgs, ... }:

{
  programs.eww = {
    enable = true;
    configDir = ./config;
  };
}
