{ env, ... }:
let
  user = env.username;
in
{
  sops.secrets.dell_cert = {
    sopsFile = "/home/${user}/config/system/secrets/syncthing.yaml";
    owner = "${user}";
    path = "/home/${user}/.config/syncthing/keys/cert.pem";
  };
  sops.secrets.dell_key = {
    sopsFile = "/home/${user}/config/system/secrets/syncthing.yaml";
    owner = "${user}";
    path = "/home/${user}/.config/syncthing/keys/key.pem";
  };
  services.syncthing = {
    enable = true;
    key = "/home/${user}/.config/syncthing/keys/key.pem";
    cert = "/home/${user}/.config/syncthing/keys/cert.pem";
    openDefaultPorts = true;
    dataDir = "/home/${user}/.local/share/syncthing";
    configDir = "/home/${user}/.config/syncthing";
    user = "${user}";
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
          path = "/home/${user}/notes";
          devices = [ "asus" ];
          ignorePermissions = true;
        };
        "Server" = {
          path = "/home/${user}/projects/srv";
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
