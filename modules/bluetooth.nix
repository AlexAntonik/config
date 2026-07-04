{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.bluez # Bluetooth utilities
    pkgs.blueman # Bluetooth manager
  ];

  services.blueman.enable = true;
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
      settings.Policy.AutoEnable = "true";
    };
  };
}
