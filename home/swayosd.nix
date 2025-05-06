{username, pkgs-unstable, ...}:
{
  services.swayosd = {
    enable = true;
    stylePath = /home/${username}/.config/swayosd/style.css;
    package = pkgs-unstable.swayosd;
  };
  home.file.".config/swayosd/style.css".text = ''
    window#osd {
      padding: 12px 20px;
      border-radius: 999px;
      border: 2px solid rgba(255, 255, 255, 0.14);
      background: rgba(30, 30, 30, 0.8);
    }

    #container {
      margin: 16px;
    }

    image,
    label {
      color: rgba(255, 255, 255, 0.9);
    }

    progressbar:disabled,
    image:disabled {
      opacity: 0.5;
    }

    progressbar {
      min-height: 6px;
      border-radius: 999px;
      background: transparent;
      border: none;
    }

    trough {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background: rgba(255, 255, 255, 0.5);
    }

    progress {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background: rgba(255, 255, 255, 0.9);
    }
  '';
}
