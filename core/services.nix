{
  pkgs,
  username,
  host,
  ...
}:
let
  inherit (import ../hosts/${host}/variables.nix) keyboardLayout;
in
{

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.hyprland ];
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
  # Services to start
  services = {
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    # flatpak.enable = true;
    openssh = {
      enable = true; # Enable SSH
      settings = {
        PermitRootLogin = "no"; # Prevent root from SSH login
        PasswordAuthentication = true; # Users can SSH using kb and password
        KbdInteractiveAuthentication = true;
      };
      ports = [ 22 ];
    };

    blueman.enable = true;

    # with tlp laptop is hotter, idk why
    # tlp = {
    #   enable = true;
    #   settings = {
    #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

    #     CPU_MIN_PERF_ON_AC = 0;
    #     CPU_MAX_PERF_ON_AC = 80;
    #     CPU_MIN_PERF_ON_BAT = 0;
    #     CPU_MAX_PERF_ON_BAT = 30;

    #     #Optional helps save long term battery health
    #     START_CHARGE_THRESH_BAT0 = 50; # 40 and below it starts to charge
    #     STOP_CHARGE_THRESH_BAT0 = 90; # 80 and above it stops charging

    #   };
    # };

    journald = {
      extraConfig = ''
        SystemMaxUse=100M
        SystemKeepFree=1G
        SystemMaxFileSize=50M
        RuntimeMaxUse=100M

        Storage=persistent
        Compress=yes
        SyncIntervalSec=5m

        MaxRetentionSec=1month
        MaxFileSec=1week
      '';
    };

    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
        options = "grp:win_space_toggle"; # also need to be changed in hyprland config
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

    rpcbind.enable = true;
    nfs.server.enable = true;
  };

  # systemd.services.flatpak-repo = {
  #   wantedBy = [ "multi-user.target" ];
  #   path = [ pkgs.flatpak ];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };

  # Security / Polkit
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
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
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };
}
