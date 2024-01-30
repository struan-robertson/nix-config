{ config, lib, pkgs, pkgs-custom, ... }:

{
  programs.dconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true;

  # TODO: remove when libopenraw is added to tumbler
  # services.tumbler.enable = true;
  environment.systemPackages = with pkgs-custom.xfce; [
    tumbler
  ];
  services.dbus.packages = with pkgs-custom.xfce; [
    tumbler
  ];
}
