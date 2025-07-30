{ username, ... }:
{
  sops.secrets.dell_cert = {
    sopsFile = "/home/${username}/config/system/secrets/syncthing.yaml";
    owner = "${username}";
    path = "/home/${username}/.config/syncthing/keys/cert.pem";
  };
  sops.secrets.dell_key = {
    sopsFile = "/home/${username}/config/system/secrets/syncthing.yaml";
    owner = "${username}";
    path = "/home/${username}/.config/syncthing/keys/key.pem";
  };
  services.syncthing = {
    enable = true;
    key = "/home/${username}/.config/syncthing/keys/key.pem";
    cert = "/home/${username}/.config/syncthing/keys/cert.pem";
    openDefaultPorts = true;
    extraFlags = [ "--no-default-folder" ];
    dataDir = "/home/${username}/.local/share/syncthing";
    configDir = "/home/${username}/.config/syncthing";
    user = "${username}";
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
        # "Server" = {
        #   path = "/home/${username}/projects/srv";
        #   versioning = {
        #     type = "staggered";
        #     params = {
        #       cleanInterval = "3600";
        #       maxAge = "15768000";
        #     };
        #   };
        #   devices = [ "asus" ];
        #   ignorePermissions = true;
        # };
        "ServerTransfer" = {
          path = "/home/${username}/projects/srv/transfer";
          devices = [ "asus" ];
          ignorePermissions = true;
        };
      };
    };
  };
}
