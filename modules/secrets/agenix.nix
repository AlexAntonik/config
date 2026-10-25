{
  inputs,
  pkgs,
  host,
  ...
}:
{
  imports = [ inputs.agenix.nixosModules.default ];

  environment = {
    sessionVariables.AGENIX_RULES = "${host.flakePath}/modules/secrets/agenix-rules.nix";
    shellAliases.anix = "sudo agenix -i /etc/ssh/ssh_host_ed25519_key";
    systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  };
}
