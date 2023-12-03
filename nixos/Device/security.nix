{ config, lib, pkgs, ... }:

{

  # rtkit for pipewire
  security.rtkit.enable = true;

  # Allow swaylock to read login information
  security.pam.services.swaylock.text = ''
    auth include login
  '';

  # Kill all user processes on user logout
  services.logind = { killUserProcesses = true; };

  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.pam.loginLimits = [{
    domain = "*";
    type = "-";
    item = "nofile";
    value = "8192";
  }];

  # SSH config
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users.users."struan".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbFfKkd0Q8eVe6MvjHZR4TVLUvc5saUifgd7WwAj5Be struanrobertson@protonmail.com"
  ];

  services.mullvad-vpn.enable = true;

}
