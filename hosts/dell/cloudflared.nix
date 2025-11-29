{ env, ... }:
let
  credsFile = "/home/${env.username}/.cloudflared/creds.json";
in
{
  sops.secrets.dell = {
    sopsFile = "/home/${env.username}/config/system/secrets/cloudflared.yaml";
    owner = "alex";
    path = credsFile;
  };
  services.cloudflared = {
    enable = true;
    tunnels = {
      "dell" = {
        credentialsFile = credsFile;
        default = "http_status:404";
      };
    };
  };
}
