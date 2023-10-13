{ config, lib, pkgs, ... }:

{
  # TODO: when I have a local NAS and dont have to use encryption, make syncthing declarative
  services.syncthing = {
    enable = true;
    user = "struan";
    dataDir = "/home/struan/Sync";
    configDir = "/home/struan/.config/syncthing";
  };

}
