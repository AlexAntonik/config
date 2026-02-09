{ username, ... }:
{
  sops.secrets.dell_cert = {
    sopsFile = "/home/${username}/config/modules/secrets/syncthing.yaml";
    owner = "${username}";
    path = "/home/${username}/.config/syncthing/keys/cert.pem";
  };
  sops.secrets.dell_key = {
    sopsFile = "/home/${username}/config/modules/secrets/syncthing.yaml";
    owner = "${username}";
    path = "/home/${username}/.config/syncthing/keys/key.pem";
  };
  services.syncthing = {
    enable = true;
    key = "/home/${username}/.config/syncthing/keys/key.pem";
    cert = "/home/${username}/.config/syncthing/keys/cert.pem";
    openDefaultPorts = true;
    dataDir = "/home/${username}/.local/share/syncthing";
    configDir = "/home/${username}/.config/syncthing";
    user = "${username}";
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
