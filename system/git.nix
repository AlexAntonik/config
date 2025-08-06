{ host, ... }:
let
  inherit (import ../hosts/${host}/env.nix) gitUsername gitEmail;
in
{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = gitUsername;
        email = gitEmail;
      };
    };
  };
}
