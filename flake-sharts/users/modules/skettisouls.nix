{ config, lib, pkgs, ... }:
let
  inherit (config.peripherals.bluetooth) headphones;
  home = config.home.homeDirectory;
in
{
  config = {
    home = {
      packages = [ pkgs.neovim ];
      sessionVariables = {
        EDITOR = "nvim";
      };
    };

    peripherals.bluetooth = {
      defaultHeadphones = headphones.momentum4;
      headphones = {
        momentum4 = "80:C3:BA:3F:EB:B9";
        spaceQ45 = "E8:EE:CC:4B:FA:2A";
      };
    };

    programs.git = {
      userName = "SkettiSouls";
      userEmail = "skettisouls@gmail.com";

      signing.key = home + "/.keys/ssh/git.key";
    };

    shit = {
      git.enable = true;
      gpg.enable = true;

      bash = {
        enable = true;
        aliaspp.enable = true;
      };
    };

    xdg = {
      enable = true;

      cacheHome = "${home}/.cache";
      configHome = "${home}/.config";
      dataHome = "${home}/.local/share";
      stateHome = "${home}/.local/state";

      userDirs = rec {
        enable = true;
        createDirectories = true;

        download = "${home}/Downloads";
        desktop = "${home}/Desktop";
        documents = "${home}/Documents";
        music = "${home}/Music";
        pictures = "${home}/Pictures";
        videos = "${home}/Videos";

        templates = null;
        publicShare = null;

        extraConfig = {
          XDG_SCREENSHOTS_DIR = "${pictures}/screenshots";
        };
      };
    };
  };
}
