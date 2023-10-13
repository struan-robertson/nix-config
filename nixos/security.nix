{ config, lib, pkgs, ... }:

{
  # Allow swaylock to read login information
  security.pam.services.swaylock.text = ''
    auth include login
  '';

  # Kill all user processes on user logout
  services.logind = {
    killUserProcesses = true;
  };

  # Allow brillo to change brightness settings
  services.udev = {
    enable = true;
    packages = [
      pkgs.brillo
    ];
  };
}
