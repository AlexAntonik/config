{
  pkgs,
  config,
  ...
}:
{
  services.forgejo = {
    enable = true;
    package = pkgs.forgejo-lts;

    settings = {
      DEFAULT.APP_NAME = "forgejo";

      server = {
        HTTP_ADDR = "0.0.0.0";
        HTTP_PORT = 3000;

        START_SSH_SERVER = false;
        SSH_PORT = 22;

        PROTOCOL = "http";
      };

      session.COOKIE_SECURE = true;

      service = {
        DISABLE_REGISTRATION = true;
        REQUIRE_SIGNIN_VIEW = false;
      };

      actions = {
        ENABLED = true;
      };

      log.LEVEL = "Info";
    };
  };

  systemd.services.forgejo-fqdn = {
    description = "Resolve Tailscale DNS name for forgejo ROOT_URL";
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
    before = [ "forgejo.service" ];
    wantedBy = [ "forgejo.service" ];
    path = [
      pkgs.jq
      pkgs.gnused
      config.services.tailscale.package
    ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      fqdn="$(tailscale status --json | jq -r '.Self.DNSName' | sed 's/\.$//')"
      if [ -n "$fqdn" ]; then
        mkdir -p /run/forgejo
        printf 'FORGEJO__server__DOMAIN=%s\nFORGEJO__server__ROOT_URL=https://%s/\n' "$fqdn" "$fqdn" > /run/forgejo/root-url.env
        echo "forgejo-fqdn: ROOT_URL = https://$fqdn/"
      fi
    '';
  };

  systemd.services.forgejo = {
    after = [ "forgejo-fqdn.service" ];
    serviceConfig.EnvironmentFile = "-/run/forgejo/root-url.env";
  };

  age.secrets.forgejo-runner-dell-token.file = ../../modules/secrets/forgejo-runner-dell-token.age;
  services.forgejo-runner.instances.dell = {
    enable = false;

    settings = {
      runner.labels = [
        "ubuntu-latest:docker://node:20-bookworm"
        "ubuntu-22.04:docker://node:20-bookworm"
      ];

      server.connections.dell = {
        url = "http://127.0.0.1:3000/";
        # Fill in after registration:
        uuid = "";
      };
    };

    secrets.server.connections.dell.token_url = config.age.secrets.forgejo-runner-dell-token.path;
  };

}
