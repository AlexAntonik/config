{
  pkgs,
  host,
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
        DOMAIN = "git.happygin.net";
        ROOT_URL = "https://git.happygin.net/";

        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3000;

        START_SSH_SERVER = false;
        SSH_PORT = 22;

        PROTOCOL = "http";
      };

      # Served over HTTPS by nginx.
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

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = host.gitEmail;
      dnsProvider = "cloudflare";
      credentialFiles."CF_DNS_API_TOKEN_FILE" = config.age.secrets.acme-cloudflare-creds.path;

      dnsResolver = "1.1.1.1:53";
    };
    certs."git.happygin.net".group = "nginx";
  };

  services.nginx = {
    enable = true;
    virtualHosts."git.happygin.net" = {
      onlySSL = true;
      useACMEHost = "git.happygin.net";
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true; # live log streaming of Actions jobs
        extraConfig = ''
          client_max_body_size 512m; # git push limit
        '';
      };
    };
  };

  systemd.services.forgejo-admin-user = {
    description = "Ensure forgejo admin user exists";
    after = [ "forgejo.service" ];
    wants = [ "forgejo.service" ];
    wantedBy = [ "multi-user.target" ];
    path = [ config.services.forgejo.package ];
    serviceConfig = {
      Type = "oneshot";
      User = config.services.forgejo.user;
      Group = config.services.forgejo.group;
      Environment = [
        "HOME=${config.services.forgejo.stateDir}"
        "FORGEJO_WORK_DIR=${config.services.forgejo.stateDir}"
      ];
    };
    script = ''
      if ! forgejo admin user list | awk '{print $2}' | grep -qx "${host.username}"; then
        forgejo admin user create \
          --admin \
          --username "${host.username}" \
          --email "${host.gitEmail}" \
          --password "$(cat ${config.age.secrets.forgejo-admin-password.path})" \
          --must-change-password=false
      fi
    '';
  };

  age.secrets = {
    acme-cloudflare-creds = {
      file = ../../modules/secrets/acme-cloudflare-creds.age;
      owner = "acme";
      group = "acme";
      mode = "0400";
    };

    forgejo-admin-password = {
      file = ../../modules/secrets/forgejo-admin-password.age;
      owner = "forgejo";
      group = "forgejo";
      mode = "0400";
    };

    forgejo-runner-dell-token.file = ../../modules/secrets/forgejo-runner-dell-token.age;
  };

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
