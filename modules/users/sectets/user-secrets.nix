{ host, ... }: {
  imports = [
    ./../../secrets/agenix.nix
  ];
  age.secrets = {
    desktop-user-pwd-hash = {
      file = ./desktop-user-pwd-hash.age;
      owner = host.username;
    };
    server-user-pwd-hash = {
      file = ./server-user-pwd-hash.age;
      owner = host.username;
    };
  };
}