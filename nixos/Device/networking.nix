{ config, lib, pkgs, ... }:

{
  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 9090 ];
    allowedUDPPorts = [ 9090 ];
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
