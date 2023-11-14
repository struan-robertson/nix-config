{ config, lib, pkgs, ... }:

{
  networking.hostName = "nix";
  networking.networkmanager.enable = true;
}
