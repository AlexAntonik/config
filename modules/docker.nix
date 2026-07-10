{ pkgs, host, ... }:
{
  virtualisation.docker.enable = true;

  users.users.${host.username}.extraGroups = [ "docker" ];
  
  environment.shellAliases = {
    ld = "lazydocker";
  };

  environment.systemPackages = [
    pkgs.docker-compose # Multi-container orchestration
    pkgs.docker-ls # Docker registry and image exploration
    pkgs.lazydocker # Terminal UI for Docker management
  ];
}
