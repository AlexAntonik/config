{ host, ... }: {
  imports = [
    ./../../../modules/secrets/agenix.nix
  ];

  age.secrets = {
    asus-sync-cert = {
      file = ./asus-sync-cert.pem.age;
      owner = "${host.username}";
    };
    asus-sync-key = {
      file = ./asus-sync-key.pem.age;
      owner = "${host.username}";
    };
  };
}
