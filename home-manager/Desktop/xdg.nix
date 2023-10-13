{ config, lib, pkgs, ... }:

{
  xdg.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.mime.enable = true;
  xdg.systemDirs.data =
    [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "sioyek.desktop" "firefox.desktop" ];
    };
  };

  home.sessionVariables = { SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent"; };

}
