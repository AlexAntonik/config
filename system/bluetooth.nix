{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bluez # Bluetooth utilities
    blueman # Bluetooth manager
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
