{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    tofi
  ];

  xdg.configFile."tofi/config".text = ''
    width = 200%
    height = 200%
    border-width = 0
    outline-width = 0
    padding-left = 97%
    padding-top = 75%
    result-spacing = 25
    num-results = 9
    font = /home/struan/Sync/bin/InterNerdFont-Regular.otf
    background-color = #000A
    text-color = #ECEFF4
    selection-color = #5E81AC
    prompt-text ="󰑮 "
  '';
}
