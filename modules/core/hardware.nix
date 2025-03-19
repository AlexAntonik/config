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
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      #package = pkgs.bluez5-experimental;
      package = pkgs.bluez;
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
        JustWorksRepairing = "always";
        DiscoverableTimeout = "0";
        PairableTimeout = "0";
        Discovery = "dual";
      };
    };
  };
  local.hardware-clock.enable = false;
}
