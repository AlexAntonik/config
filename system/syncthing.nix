{ username, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/${username}/.local/share/syncthing";
    configDir = "/home/${username}/.config/syncthing";
    user = "${username}";
    settings = {
      folders = {
        "Notes" = {
          path = "/home/${username}/notes";
        };
      };
    };
  };
}
