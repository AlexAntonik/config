{ inputs, pkgs, ... }:
{
  imports = [ inputs.agenix.nixosModules.default ];

  environment.etc."agenix/agenix-rules.nix".source = ./agenix-rules.nix;
  environment.sessionVariables.AGENIX_RULES = "/etc/agenix/agenix-rules.nix";
  environment.shellAliases.anix = "sudo agenix -i /etc/ssh/ssh_host_ed25519_key";
  environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
