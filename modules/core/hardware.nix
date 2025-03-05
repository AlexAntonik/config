{ pkgs, ... }:
{
  hardware = {
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    logitech.wireless.enable = false;
    logitech.wireless.enableGraphical = false;
    graphics.enable = true;
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
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
          DiscoverableTimeout = "0";
          PairableTimeout = "0";
          Discovery = "dual";
      };
    };
  };
  local.hardware-clock.enable = false;
}
