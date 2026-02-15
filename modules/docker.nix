{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  
  environment.systemPackages = with pkgs; [
    docker-compose     # Multi-container orchestration
    docker-ls          # Docker registry and image exploration
    lazydocker         # Terminal UI for Docker management
  ];
}
