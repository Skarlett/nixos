{ moduleWithSystem, ... }:

{
  config.flake = {
    nixosModules.skettisouls = moduleWithSystem (
      perSystem@{ config }:
      _:
      {
        users.users.skettisouls = let
          wrappers = perSystem.config.wrappedPackages.skettisouls;
        in {
          # Nushell is really nice but has a major lack of command completion.
          # shell = wrappers.nushell;
          packages = with wrappers; [
            eza
            feishin
            nushell
          ];
        };
      }
      );

    users.skettisouls = {
      home-manager = {
        enable = true;
        modules = import ./home-manager;
      };

      wrapper-manager = {
        enable = true;
        modules = ./wrapper-manager;
      };
    };
  };
}
