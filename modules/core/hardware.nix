{ pkgs, ... }:
{
  hardware = {
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
    logitech.wireless.enable = false;
    logitech.wireless.enableGraphical = false;
    graphics.enable = true;
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;  # Полная версия с поддержкой всех кодеков
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      extraConfig = ''
        load-module module-switch-on-connect
        load-module module-bluetooth-policy
        load-module module-bluetooth-discover
        load-module module-native-protocol-tcp
      '';
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez5-experimental;
      #package = pkgs.bluez;
      settings.Policy.AutoEnable = "true";
      settings.General = {
          Enable = "Source,Sink,Media,Socket";
          Name = "NixOS";
          ControllerMode = "dual";
          FastConnectable = "true";
          Experimental = "true";
          KernelExperimental = "true";
          MultiProfile = "multiple"; 
          AutoEnable = "true";
          Class = "0x240404";
          Privacy = "device";
          JustWorksRepairing = "always";
      };
    };
  };
  local.hardware-clock.enable = false;
}
