{ config, lib, pkgs, ... }:

{

  # rtkit for pipewire
  security.rtkit.enable = true;

  # Allow swaylock to read login information
  security.pam.services.swaylock.text = ''
    auth include login
  '';

  # Kill all user processes on user logout
  services.logind = {
    killUserProcesses = true;
  };

  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Allow brillo to change brightness settings
  services.udev = {
    enable = true;
    packages = [
      pkgs.brillo
    ];
  };
}
