{ host, ... }:
{
  imports = [ ./../../modules/secrets/sops.nix ];
  sops.secrets.asus_cert = {
    sopsFile = "/home/${host.username}/config/modules/secrets/syncthing.yaml";
    owner = "${host.username}";
    path = "/home/${host.username}/.config/syncthing/keys/cert.pem";
  };
  sops.secrets.asus_key = {
    sopsFile = "/home/${host.username}/config/modules/secrets/syncthing.yaml";
    owner = "${host.username}";
    path = "/home/${host.username}/.config/syncthing/keys/key.pem";
  };
  services.syncthing = {
    enable = true;
    key = "/home/${host.username}/.config/syncthing/keys/key.pem";
    cert = "/home/${host.username}/.config/syncthing/keys/cert.pem";
    openDefaultPorts = true;
    dataDir = "/home/${host.username}/.local/share/syncthing";
    configDir = "/home/${host.username}/.config/syncthing";
    user = "${host.username}";
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
          path = "/home/${host.username}/notes";
          devices = [ "dell" ];
          ignorePermissions = true;
        };
        "Server" = {
          path = "/home/${host.username}/projects/srv";
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
          path = "/home/${host.username}/projects/prod/backup";
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
          path = "/home/${host.username}/projects/srv/transfer";
          devices = [ "swop" ];
          ignorePermissions = true;
        };
      };
    };
  };
}
