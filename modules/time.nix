{ host, ... }:
{
  time.timeZone = "${host.timeZone}";
  i18n.defaultLocale = "${host.defaultLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${host.extraLocaleSettings}";
    LC_IDENTIFICATION = "${host.extraLocaleSettings}";
    LC_MEASUREMENT = "${host.extraLocaleSettings}";
    LC_MONETARY = "${host.extraLocaleSettings}";
    LC_NAME = "${host.extraLocaleSettings}";
    LC_NUMERIC = "${host.extraLocaleSettings}";
    LC_PAPER = "${host.extraLocaleSettings}";
    LC_TELEPHONE = "${host.extraLocaleSettings}";
    LC_TIME = "${host.extraLocaleSettings}";
  };
}
