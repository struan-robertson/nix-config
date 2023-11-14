{ config, lib, pkgs, ... }:

{

  # Fonts

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
    font-awesome
    inter
    times-newer-roman
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra

    # Emacs icons
    emacs-all-the-icons-fonts
  ];

  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "FiraCode Nerd Font" ];
      sansSerif = [ "Inter" ];
      serif = [ "Times Newer Roman" ];
    };
  };
}
