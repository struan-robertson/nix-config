{ config, lib, pkgs, ... }:

{

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };

    systemDirs.data =
      [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "sioyek.desktop" "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
      };
    };

    xdg.configFile."mimeapps.list".force = true;

  };

  home.sessionVariables = { SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent"; };

}
