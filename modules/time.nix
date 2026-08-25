{ host, ... }:
{
  time.timeZone = host.timeZone;
  i18n.defaultLocale = host.defaultLocale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = host.defaultLocale;
    LC_IDENTIFICATION = host.defaultLocale;
    LC_MEASUREMENT = host.defaultLocale;
    LC_MONETARY = host.defaultLocale;
    LC_NAME = host.defaultLocale;
    LC_NUMERIC = host.defaultLocale;
    LC_PAPER = host.defaultLocale;
    LC_TELEPHONE = host.defaultLocale;
    LC_TIME = host.defaultLocale;
  };
}
