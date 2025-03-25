{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername gitEmail;
in
{
  programs.git = {
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };
}
