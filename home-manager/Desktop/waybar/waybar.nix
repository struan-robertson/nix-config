{ pkgs, ... }:
{
  programs.waybar = {
  
    enable = true;

#   package = pkgs.waybar.overrideAttrs (oa: {
#     mesonFlags = (oa.mesonFlags or []) ++ [ "-Dexperimental=true" ];
#     patches = (oa.patches or []) ++ [
#       (pkgs.fetchpatch {
#         name = "fix waybar hyprctl";
#         url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";       
#         sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";  
#       })
#     ];
#   });

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
      
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "idle_inhibitor" "network" "cpu" "memory" "disk" "battery" ]; 

        "hyprland/workspaces" = {
          format = "{name} {icon}";
          on-click = "activate";
          sort-by-number = true;
          format-icons = {
            "1" = "<span font='Font Awesome 6 Free'></span>";
            "2" = "<span font='Font Awesome 6 Free'></span>";
            "3" = "<span font='Font Awesome 6 Free'></span>";
            "default" = "";
          };
        };

        "hyprland/window" = {
          max-length = 60;
          tooltip = false;
        };

        clock = {
          timezone = "Europe/London";
          format = "{:%a %d %b - %H:%M}";
          tooltip = false;
        };

        cpu = {
          format = "<span font='Font Awesome 6 Free'>{icon}</span> {usage}%";
          format-icons = [ "" ];
          escape = true;
          on-click = "wezterm htop";
        };

        memory = {
          format = "<span font='Font Awesome 6 Free'>{icon}</span> {}%";
          format-icons = [ "" ];
          on-click = "wezterm htop";
        };

        battery = {
          format = "<span font='Font Awesome 6 Free'>{icon}</span> {capacity}%";
          format-icons = [ "" "" "" "" "" ];
          format-charging = "<span font='Font Awesome 6 Free'></span> <span font='Font Awesome 6 Free 11'>{icon}</span> {capacity}%";
          format-full = "<span font='Font Awesome 6 Free'></span> <span font='Font Awesome 6 Free 11'>{icon}</span>";
          interval = 30;
          states = {
            warning = 25;
            critical = 10;
          };
          tooltip = false;
        };

        network = {
          format = "{icon}";
          format-alt = "{ipaddr}/{cidr} {icon}";
          format-alt-click = "click-right";
          format-wifi = "<span font='Font Awesome 6 Free'></span> {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = "<span font='Font Awesome 6 Free'>⚠</span> Disconnected";
          on-click = "wezterm nmtui";
          tooltip = false;
        };

        disk = {
          interval = 30;
          format = "<span font='Font Awesome 6 Free'></span> {percentage_used}%";
          path = "/";
          on-click = "duc gui /home/struan";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "<span font='Font Awesome 6 Free'></span>";
            deactivated = "<span font='Font Awesome 6 Free'></span>";
          };
          tooltip = false;
        };

        tray = {
          icon-size = 18;
          spacing = 18;
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
