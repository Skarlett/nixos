{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  inherit (config.basalt) hyprland;

  cfg = config.basalt.udiskie;
in
{
  options.basalt.udiskie = {
    enable = mkEnableOption "udiskie";
  };

  config = mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      automount = true;
      # TODO: Switch to dunst.enable once dunst module is made.
      notify = mkIf hyprland.enable true;
      tray = "never";

      settings = {
        # see https://github.com/coldfix/udiskie/blob/master/doc/udiskie.8.txt#configuration
      };
    };
  };
}
