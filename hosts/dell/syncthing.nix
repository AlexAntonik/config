{ host, config, ... }:
{
  imports = [
    ../../modules/secrets/agenix.nix
  ];
  age.secrets = {
    dell-sync-cert = {
      file = ./secrets/dell-sync-cert.pem.age;
      owner = host.username;
    };
    dell-sync-key = {
      file = ./secrets/dell-sync-key.pem.age;
      owner = host.username;
    };
  };
  services.syncthing = {
    enable = true;
    key = config.age.secrets.dell-sync-key.path;
    cert = config.age.secrets.dell-sync-cert.path;
    openDefaultPorts = true;
    dataDir = "/home/${host.username}/.local/share/syncthing";
    configDir = "/home/${host.username}/.config/syncthing";
    user = host.username;
    settings = {
      devices = {
        "asus" = {
          id = "KXS3ZTW-OEPU4MR-35LYCZT-OFVQTNW-YCVFMBQ-L62CFV5-4OYT5J7-UWUVSAZ";
        };
        "swop" = {
          id = "PAZXHAF-J3ZFUS5-R576QL2-EOUCZJ3-RBY3YSV-QG5XGTU-JWQGARY-FOM4JQF";
        };
      };
      folders = {
        "Notes" = {
          path = "/home/${host.username}/notes";
          devices = [ "asus" ];
          ignorePermissions = true;
        };
        "Server" = {
          path = "/home/${host.username}/projects/srv";
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "15768000";
            };
          };
          devices = [ "asus" ];
          ignorePermissions = true;
        };
      };
    };
  };
}
