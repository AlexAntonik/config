let
  alex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID6f3MkgmZZaFCgeRfPPX8sZZzEswJ3FVvs9l+4+kkB2";

  dell = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4ig3EhahqRstrCnCpXht4lB7LRrJvBZ6rHBH/gmTlY";
  swprod = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfz5/RJvjudWb6h9j8TGhfBFAdNY0KbNkjqnpWmaiX0";
in
{
  "asus-sync-cert.pem.age" = {
    publicKeys = [ alex ];
    armor = true;
  };
  "asus-sync-key.pem.age" = {
    publicKeys = [ alex ];
    armor = true;
  };
  "dell-sync-cert.pem.age" = {
    publicKeys = [ alex dell ];
    armor = true;
  };
  "dell-sync-key.pem.age" = {
    publicKeys = [ alex dell ];
    armor = true;
  };
  "swprod-sync-cert.pem.age" = {
    publicKeys = [ alex swprod ];
    armor = true;
  };
  "swprod-sync-key.pem.age" = {
    publicKeys = [ alex swprod ];
    armor = true;
  };
  "cloudflare-creds.json.age" = {
    publicKeys = [ alex dell ];
    armor = true;
  };
  "desktop-user-pwd-hash.age" = {
    publicKeys = [ alex ];
    armor = true;
  };
  "server-user-pwd-hash.age" = {
    publicKeys = [ alex dell];
    armor = true;
  };
  "swprod-user-pwd-hash.age" = {
    publicKeys = [ alex swprod ];
    armor = true;
  };
}