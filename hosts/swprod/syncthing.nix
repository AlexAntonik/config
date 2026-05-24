{ host, ... }:
{
  sops.secrets.swop_cert = {
    sopsFile = "${host.flakePath}/modules/secrets/syncthing.yaml";
    owner = "${host.username}";
    path = "/home/${host.username}/.config/syncthing/keys/cert.pem";
  };
  sops.secrets.swop_key = {
    sopsFile = "${host.flakePath}/modules/secrets/syncthing.yaml";
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
        "asus" = {
          id = "KXS3ZTW-OEPU4MR-35LYCZT-OFVQTNW-YCVFMBQ-L62CFV5-4OYT5J7-UWUVSAZ";
        };
        "dell" = {
          id = "DEEMPVX-NTNLLUM-IXRXV3N-47N6AB7-CETLFHL-5PXB25D-KT5HNL5-ZMQ4SQT";
        };
      };
      folders = {
        "Prod" = {
          path = "/home/${host.username}/projects/srv/backup";
          devices = [ "asus" ];
          type = "sendonly";
          ignorePermissions = true;
        };
        "ServerTransfer" = {
          path = "/home/${host.username}/projects/srv/transfer";
          devices = [ "asus" ];
          ignorePermissions = true;
        };
      };
    };
  };
}
