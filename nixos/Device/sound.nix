{ config, lib, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.etc."wireplumber/main.lua.d/51-disable-suspension.lua".text = ''
    table.insert (alsa_monitor.rules, {
      matches = {
        {
          -- Matches all sources.
          { "node.name", "matches", "alsa_input.*" },
        },
        {
          -- Matches all sinks.
          { "node.name", "matches", "alsa_output.*" },
        },
      },
      apply_properties = {
        ["session.suspend-timeout-seconds"] = 0,  -- 0 disables suspend
      },
    })
  '';

  environment.etc."wireplumber/bluetooth.lua.d/51-disable-suspension.lua".text = ''
    -- Note: bluez_monitor, not alsa_monitor
    table.insert (bluez_monitor.rules, {
      matches = {
        {
          -- Matches all sources.
          -- Note: bluez_input, not alsa_input
          { "node.name", "matches", "bluez_input.*" },
        },
        {
          -- Matches all sinks.
          -- Note: bluez_output, not alsa_output
          { "node.name", "matches", "bluez_output.*" },
        },
      },
      apply_properties = {
        ["session.suspend-timeout-seconds"] = 0,  -- 0 disables suspend
      },
    })
  '';
}
