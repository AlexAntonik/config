{
  flake.nixosModules.obs =
    { ... }:
    {
      programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
      };
    };
}
