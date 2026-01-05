{ env, ... }:
let
  user = env.username;
in
{
  sops.secrets.asus_cert = {
    sopsFile = "/home/${user}/config/system/secrets/syncthing.yaml";
    owner = "alex";
    path = "/home/${user}/.config/syncthing/keys/cert.pem";
  };
  sops.secrets.asus_key = {
    sopsFile = "/home/${user}/config/system/secrets/syncthing.yaml";
    owner = "alex";
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
        "dell" = {
          id = "DEEMPVX-NTNLLUM-IXRXV3N-47N6AB7-CETLFHL-5PXB25D-KT5HNL5-ZMQ4SQT";
        };
        "swop" = {
          id = "PAZXHAF-J3ZFUS5-R576QL2-EOUCZJ3-RBY3YSV-QG5XGTU-JWQGARY-FOM4JQF";
        };
      };
      folders = {
        "Notes" = {
          path = "/home/${user}/notes";
          devices = [ "dell" ];
          ignorePermissions = true;
        };
        "Server" = {
          path = "/home/${user}/projects/srv";
          devices = [
            "dell"
          ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "15768000";
            };
          };
          ignorePermissions = true;
        };
        "Prod" = {
          path = "/home/${user}/projects/prod/backup";
          type = "receiveonly";
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "2764800";
            };
          };
          devices = [ "swop" ];
          ignorePermissions = true;
        };
        "ServerTransfer" = {
          path = "/home/${user}/projects/srv/transfer";
          devices = [ "swop" ];
          ignorePermissions = true;
        };
      };
    };
  };
}
