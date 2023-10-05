{ inputs, pkgs, config, ... }:
{

  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hyprland.conf;

  programs.swaylock = {
    enable = true;
    settings = {
      daemonize = true;
      ignore-empty-password = true;
      image = "/home/struan/Pictures/background.jpg";
      font = "Inter";
      indicator-radius = 100;
      indicator-thickness = 10;
      line-uses-ring = true;

      # Nord Theme
      inside-color = "2e3440ff";
      inside-clear-color = "81a1c1ff";
      inside-ver-color = "5e81acff";
      inside-wrong-color = "bf616aff";
      key-hl-color = "a3be8cff";
      layout-bg-color = "2e3440ff";
      bs-hl-color = "b48eadff";
      caps-lock-bs-hl-color = "d08770ff";
      caps-lock-key-hl-color = "ebcb8bff";
      ring-color = "3b4252ff";
      ring-clear-color = "88c0d0ff";
      ring-ver-color = "81a1c1ff";
      ring-wrong-color = "d08770ff";
      separator-color = "3b4252ff";
      text-color = "eceff4ff";
      text-clear-color = "3b4252ff";
      text-ver-color = "3b4252ff";
      text-wrong-color = "3b4252ff";
    };
  };

  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    timeouts = [
      {
        command = "${config.programs.swaylock.package}/bin/swaylock -f";
        timeout = 180;
      }
      {
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
        timeout = 360;
      }
      # TODO fix sleep after time
      # {
      #   command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on && systemctl suspend";
      #   timeout = 420;
      # }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${config.programs.swaylock.package}/bin/swaylock -f";
      }
      {
        event = "lock";
        command = "${config.programs.swaylock.package}/bin/swaylock -f";
      }
    ];
  };

  home.packages = with pkgs; [
    swaybg
    wob
    mako
    pamixer

    wluma
    brillo
  ];


}
