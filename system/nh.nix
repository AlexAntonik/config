{
  flake.nixosModules.nh =
    {
      pkgs,
      env,
      ...
    }:
    {
      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 7d --keep 5";
        };
        flake = "/home/${env.username}/config";
      };

      environment.systemPackages = with pkgs; [
        nix-output-monitor
        nvd
      ];
    };
}
