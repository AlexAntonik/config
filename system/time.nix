{host, ...}:
let
  inherit (import ../hosts/${host}/variables.nix) timeZone defaultLocale extraLocaleSettings;
in
{
  time.timeZone = "${timeZone}";
  i18n.defaultLocale = "${defaultLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${extraLocaleSettings}";
    LC_IDENTIFICATION = "${extraLocaleSettings}";
    LC_MEASUREMENT = "${extraLocaleSettings}";
    LC_MONETARY = "${extraLocaleSettings}";
    LC_NAME = "${extraLocaleSettings}";
    LC_NUMERIC = "${extraLocaleSettings}";
    LC_PAPER = "${extraLocaleSettings}";
    LC_TELEPHONE = "${extraLocaleSettings}";
    LC_TIME = "${extraLocaleSettings}";
  };
}
