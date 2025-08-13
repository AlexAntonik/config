{ username, ... }:
let 
  credsFile = "/home/${username}/.cloudflared/creds.json";
in
{
  sops.secrets.dell_private = {
    sopsFile = "/home/${username}/config/system/secrets/cloudflared.yaml";
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
