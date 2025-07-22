{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Bluetooth
    bluez-alsa # Bluetooth ALSA support
    bluez # Bluetooth utilities
    bluez-tools # Bluetooth tools
    blueman # Bluetooth manager
  ];

  blueman.enable = true;
  
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      #package = pkgs.bluez5-experimental;
      package = pkgs.bluez;
      settings.Policy.AutoEnable = "true";
      settings.General = {
        Enable = "Control,Gateway,Headset,Media,Sink,Socket,Source";
        MultiProfile = "multiple";
      };
    };
  };
  # Some config from random github repo
  # environment.etc = {
  #   "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
  #     bluez_monitor.properties = {
  #     	["bluez5.enable-sbc-xq"] = true,
  #     	["bluez5.enable-msbc"] = true,
  #     	["bluez5.enable-hw-volume"] = true,
  #     	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
  #     }
  #   '';
  # };
}
