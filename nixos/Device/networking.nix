{ config, lib, pkgs, ... }:

{
  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
