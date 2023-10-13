{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixlaptop";
  networking.networkmanager.enable = true;
}
