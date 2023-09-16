{
  programs.waybar = {
    enable = true;

    settings = {
      layer = "top";
      position = "top";
      
      modules-left = [ "wlr/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "tray" "idle_inhibitor" "network" "cpu" "memory" "disk" "battery" ]; 

      "wlr/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "1 <span font='Font Awesome 6 Free 11'></span>";
          "2" = "2 <span font='Font Awesome 6 Free 11'></span>";
          "3" = "3 <span font='Font Awesome 6 Free 11'></span>";
        };
        on-click = "activate";
        sort-by-number = true;
      };

      "hyprland/window" = {
        max-length = 60;
        tooltip = false;
      };

      clock = {
        timezone = "Europe/London";
        format = "{:%a %d %b - %H:%M}";
        tooltip-format = "<big>{:%B %Y}</big>\n<tt><big>{calendar}</big></tt>";
      };

      cpu = {
        format = "<span font='Font Awesome 6 Free 11'>{icon}</span> {usage}%";
        format-icons = [ "" ];
        escape = true;
        on-click = "wezterm htop";
      };

      memory = {
        format = "<span font='Font Awesome 6 Free 11'>{icon}</span> {}%";
        format-icons = [ "" ];
        on-click = "wezterm htop";
      };

      battery = {
        format = "<span font='Font Awesome 6 Free 11'>{icon}</span> {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        format-charging = "<span font='Font Awesome 6 Free 11'></span> <span font='Font Awesome 6 Free 11'>{icon}</span> {capacity}%";
        format-full = "<span font='Font Awesome 6 Free 11'></span> <span font='Font Awesome 6 Free 11'>{icon}</span>";
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
        format-wifi = "<span font='Font Awesome 6 Free 11'></span> {essid} ({signalStrength}%)";
        format-ethernet = " {ifname}";
        format-disconnected = "<span font='Font Awesome 6 Free 11'>⚠</span> Disconnected";
        on-click = "wezterm nmtui";
        tooltip = false;
      };

      disk = {
        interval = 30;
        format = "<span font='Font Awesome 6 Free 11'></span> {percentage_used}%";
        path = "/";
        on-click = "duc gui /home/struan";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "<span font='Font Awesome 6 Free 11'></span>";
          deactivated = "<span font='Font Awesome 6 Free 11'></span>";
        };
        tooltip = false;
      };

      tray = {
        icon-size = 18;
        spacing = 18;
      };

    };

    style = builtins.readFile ./style.css;
  };
}