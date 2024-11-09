{
  config = {
    users.skettisouls = {
      home-manager.enable = true;
      wrapper-manager = {
        enable = true;
        installedWrappers = [
          "eza"
          "feishin"
        ];
      };
    };

    flake.userModules.skettisouls = {
      home-manager = import ./home-manager;
      wrapper-manager = import ./wrapper-manager;
    };
  };
}
