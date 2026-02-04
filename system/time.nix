{
  flake.nixosModules.time =
    { env, ... }:
    {
      time.timeZone = "${env.timeZone}";
      i18n.defaultLocale = "${env.defaultLocale}";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "${env.extraLocaleSettings}";
        LC_IDENTIFICATION = "${env.extraLocaleSettings}";
        LC_MEASUREMENT = "${env.extraLocaleSettings}";
        LC_MONETARY = "${env.extraLocaleSettings}";
        LC_NAME = "${env.extraLocaleSettings}";
        LC_NUMERIC = "${env.extraLocaleSettings}";
        LC_PAPER = "${env.extraLocaleSettings}";
        LC_TELEPHONE = "${env.extraLocaleSettings}";
        LC_TIME = "${env.extraLocaleSettings}";
      };
    };
}
