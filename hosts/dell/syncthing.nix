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
        "asus" = {
          id = "V3B6HRT-4PYLWXR-LUGEXW7-4VDVC3T-F7TQTSR-CSWVVGW-GSKRHQN-R3ZNUAM";
        };
      };
      folders = {
        "Notes" = {
          path = "/home/${username}/notes";
          devices = [ "asus" ];
          ignorePermissions = true;
        };
        "Server" = {
          path = "/srv/supabase/";
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
