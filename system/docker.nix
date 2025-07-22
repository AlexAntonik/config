{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose # Allows controlling Docker from a single file
    docker-color-output # Adds color to Docker CLI output
    docker-ls # Registry and image management tool
    lazydocker # Terminal UI for Docker
  ];
}
