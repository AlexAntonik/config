{ env, ... }:
let
  user = env.username;
in
{
  sops.secrets.swop_cert = {
    sopsFile = "/home/${user}/config/modules/secrets/syncthing.yaml";
    owner = "${user}";
    path = "/home/${user}/.config/syncthing/keys/cert.pem";
  };
  sops.secrets.swop_key = {
    sopsFile = "/home/${user}/config/modules/secrets/syncthing.yaml";
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
        "dell" = {
          id = "DEEMPVX-NTNLLUM-IXRXV3N-47N6AB7-CETLFHL-5PXB25D-KT5HNL5-ZMQ4SQT";
        };
      };
      folders = {
        "Prod" = {
          path = "/home/${user}/projects/srv/backup";
          devices = [ "asus" ];
          type = "sendonly";
          ignorePermissions = true;
        };
        "ServerTransfer" = {
          path = "/home/${user}/projects/srv/transfer";
          devices = [ "asus" ];
          ignorePermissions = true;
        };
      };
    };
  };
}
