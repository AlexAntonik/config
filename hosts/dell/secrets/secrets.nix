{ host, ... }: {
  imports = [
    ./../../../modules/secrets/agenix.nix
  ];
  age.secrets = {
    dell-sync-cert = {
      file = ./dell-sync-cert.pem.age;
      owner = host.username;
    };
    dell-sync-key = {
      file = ./dell-sync-key.pem.age;
      owner = host.username;
    };
    cloudflare-creds = {
      file = ./cloudflare-creds.json.age;
      owner = host.username;
    };
  };
}
