{config, ...}:{
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
