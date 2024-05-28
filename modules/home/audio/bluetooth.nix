{ config, lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.shit.audio.bluetooth;
in
{
  options.shit.audio.bluetooth = {
    enable = mkEnableOption "User bluetooth config.";
  };

  config = mkIf cfg.enable {
    home.file = {
      # Fever dream, not sure if I should remove it.
      ".config/wireplumber/policy.lua.d/11-bluetooth-policy.lua".text = ''
        -- Disable bluetooth codec switching
        bluetooth_policy.policy["media-role.use-headset-profile"] = false
      '';
      # SHOULD disable PipeWire's HSP/HFP profile.
      ".config/wireplumber/wireplumber.conf.d/50-bluez.conf".text = ''
        monitor.bluez.rules = [
          {
            matches = [
              {
                ## This matches all bluetooth devices.
                device.name = "~bluez_card.*"
              }
            ]
            actions = {
              update-props = {
                bluez5.auto-connect = [ a2dp_sink ]
                bluez5.hw-volume = [ a2dp_sink ]
              }
            }
          }
        ]

        monitor.bluez.properties = {
          bluez.roles = [ a2dp_sink ]
          bluez.hfphsp-backend = "none"
        }
      '';
    };
  };
}
