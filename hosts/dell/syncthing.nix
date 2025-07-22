{ username, ... }:
{
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
          path = "/home/${username}/projects/srv";
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
