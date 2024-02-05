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
        "image/jpg" = [ "imv-dir.desktop" ];
        "image/png" = [ "imv-dir.desktop" ];
      };
    };

    configFile."mimeapps.list".force = true;

  };

  home.sessionVariables = { SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent"; };

}
