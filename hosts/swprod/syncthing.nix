{ host, config, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    key = config.age.secrets.swprod-sync-key.path;
    cert = config.age.secrets.swprod-sync-cert.path;
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
