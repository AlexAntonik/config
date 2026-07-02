{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.nixosModules.default ];
  environment.shellAliases = {
    nixzsh = "nix-shell --run zsh -p";
    nixbash = "nix-shell --run bash -p";
  };
  programs.nix-index-database.comma.enable = true;
}
