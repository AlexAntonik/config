{ host, ... }:
let
  credsFile = "/home/${host.username}/.cloudflared/creds.json";
in
{
  sops.secrets.dell = {
    sopsFile = "${host.flakePath}/modules/secrets/cloudflared.yaml";
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
