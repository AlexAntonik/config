{
  flake.nixosModules.services =
    { ... }:
    {
      services = {
        fstrim.enable = true;
        rpcbind.enable = true;
        nfs.server.enable = true;
        smartd = {
          enable = false;
          autodetect = true;
        };
        journald = {
          extraConfig = ''
            SystemMaxUse=100M
            SystemKeepFree=1G
            SystemMaxFileSize=50M
            RuntimeMaxUse=100M

            Storage=persistent
            Compress=yes
            SyncIntervalSec=5m

            MaxRetentionSec=1month
            MaxFileSec=1week
          '';
        };
      };
    };
}
