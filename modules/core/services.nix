{
  pkgs,
  username,
  host,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) keyboardLayout;
in {
  # Services to start
  services = {
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    blueman.enable = true;

    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
        options = "grp:alt_shift_toggle"; #also need to be changed in hyprland config
      };
    };
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
    smartd = {
      enable = false;
      autodetect = true;
    };
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    syncthing = {
      enable = false;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      audio.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    pipewire.wireplumber.extraConfig."10-bluez" = {
        "monitor.bluez.properties" = {
          # Existing settings
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          
          # Add these new settings for better Bluetooth audio
          "bluez5.headset-roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
          "bluez5.codecs" = ["sbc_xq" "aac" "ldac" "aptx" "aptx_hd"];
          "bluez5.enable-faststream" = true;
          "bluez5.enable-aac" = true;
          "bluez5.enable-ldac" = true;
          "bluez5.enable-aptx" = true;
          "bluez5.enable-aptx-hd" = true;
          
          # Improve connection stability
          "bluez5.auto-connect" = true;
          "bluez5.reconnect-profiles" = ["hfp_hf" "hsp_hs" "a2dp_sink"];
          
          # Keep existing roles
          "bluez5.roles" = [
            "hsp_hs"
            "hsp_ag"
            "hfp_hf"
            "hfp_ag"
          ];
        };
      };

    rpcbind.enable = true;
    nfs.server.enable = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
