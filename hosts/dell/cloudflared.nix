{ config, host, ... }: {
  imports = [
    ../../modules/secrets/agenix.nix
  ];
  age.secrets.cloudflare-creds = {
    file = ./secrets/cloudflare-creds.json.age;
    owner = host.username;
  };
  services.cloudflared = {
    enable = true;
    tunnels = {
      "dell" = {
        credentialsFile = config.age.secrets.cloudflare-creds.path;
        default = "http_status:404";
      };
    };
  };
}
