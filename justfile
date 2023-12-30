switch:
    nixos-rebuild switch --flake .\#nix --use-remote-sudo

switch-debug:
    nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

home-switch:
    home-manager switch --flake .\#struan@nix

home-switch-debug:
    home-manager switch --flake .\#struan@nix --show-trace --verbose

update:
    nix flake update

upgrade:
    nix flake update
    nixos-rebuild switch --flake .\#nix --use-remote-sudo
    home-manager switch --flake .\#struan@nix


history:
    nix profile history --profile /nix/var/nix/profiles/system

gc:
    # remove all generations older than 7 days
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

    # garbage collect all unused nix store entries
    sudo nix store gc --debug
