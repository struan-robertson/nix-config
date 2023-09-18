{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nix-doom-emacs.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacsPgtkNativeComp;
  };

  services.emacs.enable = true;
 
}
