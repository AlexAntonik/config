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
        "dell" = {
          id = "DEEMPVX-NTNLLUM-IXRXV3N-47N6AB7-CETLFHL-5PXB25D-KT5HNL5-ZMQ4SQT";
        };
      };
      folders = {
        "Notes" = {
          path = "/home/${username}/notes";
        };
      };
    };
  };
}
