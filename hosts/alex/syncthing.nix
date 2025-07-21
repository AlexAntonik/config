{ username, ... }:
{
  services.syncthing = {
    enable = true;
    key = "/var/lib/syncthing/.config/syncthing/keys/key.pem";
    cert = "/var/lib/syncthing/.config/syncthing/keys/cert.pem";
    openDefaultPorts = true;
    extraFlags = [ "--no-default-folder" ];
    dataDir = "/var/lib/syncthing/.local/share/syncthing";
    configDir = "/var/lib/syncthing/.config/syncthing";
    user = "root";
    group = "root";
    settings = {
      devices = {
        "dell" = {
          id = "DEEMPVX-NTNLLUM-IXRXV3N-47N6AB7-CETLFHL-5PXB25D-KT5HNL5-ZMQ4SQT";
        };
      };
      folders = {
        "Notes" = {
          path = "/home/${username}/notes";
          devices = [ "dell" ];
          ignorePermissions = true;
        };
        "Server" = {
          path = "/srv/supabase/";
          devices = [ "dell" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "15768000";
            };
          };
          ignorePermissions = true;
        };
      };
    };
  };
}
