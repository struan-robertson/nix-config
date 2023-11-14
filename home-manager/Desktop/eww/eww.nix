{ config, lib, pkgs, pkgs-unstable, ... }:

{
  programs.eww = {
    enable = true;
    configDir = ./config;
    package = pkgs-unstable.eww-wayland;
  };

  home.packages = with pkgs; [
    jq
    socat
    alsa-utils
    iw
  ];
}
