{ pkgs, pkgs-unstable, config, lib, ... }:
{
  home = {
    sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
  };

  programs.emacs = {
    enable = true;
    package = pkgs-unstable.emacs29-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  services.emacs.enable = true;

  home.packages = with pkgs; [
    # DOOM Emacs dependencies
    binutils

    (ripgrep.override { withPCRE2 = true; })
    gnutls
    fd
    libvterm

    imagemagick
    zstd
    nodePackages.javascript-typescript-langserver
    sqlite
    editorconfig-core-c

    pinentry-emacs
    zstd

    # :lang web
    html-tidy
    nodePackages_latest.stylelint
    nodePackages_latest.js-beautify

    # :lang sh
    shellcheck

    # :lang rust
    cargo
    rustc
    rust-analyzer

    # :lang org
    graphviz

    # :lang nix
    nixfmt

    # :lang markdown
    pandoc

    # :lang julia
    julia-bin

    # :lang python
    python3
    black
    python311Packages.pyflakes
    isort
    pipenv


    # :lang sh
    shfmt

    # :lang latex & :lang org
    texlive.combined.scheme-medium

    # :tools docker
    dockfmt

    # :tool spell
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    
  ];
}
