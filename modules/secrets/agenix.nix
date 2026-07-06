{
  inputs,
  pkgs,
  host,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];
  environment.sessionVariables = {
    RULES = "${host.flakePath}/modules/secrets/rules.nix";
  };
  environment.shellAliases = {
    anix = "sudo agenix -i /etc/ssh/ssh_host_ed25519_key";
  };
  environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
