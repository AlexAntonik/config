{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      insecure-registries = [
        # "localhost:5000"
        # "registry:5000"
        # "127.0.0.1:5000"
      ];
      #   iptables = false;
    };
  };
  environment.systemPackages = with pkgs; [
    docker-compose # Allows controlling Docker from a single file
    docker-color-output # Adds color to Docker CLI output
    docker-ls # Registry and image management tool
    lazydocker # Terminal UI for Docker
  ];
}
