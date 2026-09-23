{ inputs, pkgs, ... }:
{
  imports = [ inputs.agenix.nixosModules.default ];

  environment.etc."agenix/rules.nix".source = ./rules.nix;
  environment.sessionVariables.RULES = "/etc/agenix/rules.nix";
  environment.shellAliases.anix = "sudo agenix -i /etc/ssh/ssh_host_ed25519_key";
  environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  
  security.sudo.extraConfig = ''
    Defaults env_keep += "RULES"
  '';
}
