{ pkgs, host, ... }:
{
  virtualisation.docker.enable = true;

  users.users.${host.username}.extraGroups = [ "docker" ];
  
  environment.shellAliases = {
    ld = "lazydocker";
  };

  environment.systemPackages = with pkgs; [
    docker-compose # Multi-container orchestration
    docker-ls # Docker registry and image exploration
    lazydocker # Terminal UI for Docker management
  ];
}
