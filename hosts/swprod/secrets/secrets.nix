{ host, ... }: {
  imports = [
    ./../../../modules/secrets/agenix.nix
  ];
  age.secrets = {
    swprod-sync-cert = {
      file = ./swprod-sync-cert.pem.age;
      owner = host.username;
    };
    swprod-sync-key = {
      file = ./swprod-sync-key.pem.age;
      owner = host.username;
    };
    swprod-user-pwd-hash = {
      file = ./swprod-user-pwd-hash.age;
      owner = host.username;
    };
  };
}
