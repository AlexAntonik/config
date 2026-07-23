{ pkgs, ... }:
{
  # sleep/suspend/hibernate are disabled as they can break Bluetooth
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    "hybrid-sleep".enable = false;
  };
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
