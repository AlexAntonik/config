{ ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        "label" = "reboot";
        "action" = "sleep 1; systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "logout";
        "action" = "sleep 1; hyprctl dispatch exit";
        "text" = "Exit";
        "keybind" = "e";
      }
      {
        "label" = "suspend";
        "action" = "sleep 1; systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "lock";
        "action" = "sleep 1; hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "sleep 1; systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
    ];
    style = ''
      @define-color bar-bg rgba(0, 0, 0, 0);
      @define-color main-bg rgba(17, 17, 27, 0.5);
      @define-color main-fg rgba(205, 214, 244, 0.5);
      @define-color wb-act-bg rgba(166, 173, 200, 0.5);
      @define-color wb-act-fg rgba(49, 50, 68, 0.5);
      @define-color wb-hvr-bg rgba(230, 194, 245, 0.5);
      @define-color wb-hvr-fg rgba(49, 50, 68, 0.5);

      * {
          background-image: none;
          font-size: 18px;
      }

      window {
          background-color: transparent;
      }

      button {
          color: #ffffff;
          background-color: @main-bg;
          outline-style: none;
          border: none;
          border-width: 0px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 10%;
          border-radius: 0px;
          box-shadow: none;
          text-shadow: none;
          animation: gradient_f 20s ease-in infinite;
      }

      button:focus {
          background-color: @wb-act-bg;
          background-size: 20%;
      }

      button:hover {
          background-color: @wb-hvr-bg;
          background-size: 25%;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      }

      button:hover#lock {
          border-radius: 10px 10px 10px 0px;
          margin: 0px 0px 0px 0px;
      }

      button:hover#logout {
          border-radius: 10px 10px 0px 0px;
          margin: 0px 0px 0px 0px;
      }

      button:hover#shutdown {
          border-radius: 10px 10px 0px 10px;
          margin: 0px 0px 0px 0px;
      }

      button:hover#reboot {
          border-radius: 10px 0px 10px 10px;
          margin: 0px 0px 0px 0px;
      }

      button:hover#suspend{
          border-radius: 0px 0px 10px 10px;
          margin: 0px 0px 0px 0px;
      }

      button:hover#hibernate {
          border-radius: 0px 10px 10px 10px;
          margin: 0px 0px 0px 0px;
      }

      #lock {
          background-image: image(url("icons/lock.png"));
          border-radius: 0px 10px 0px 0px;
          margin: 10px 10px 0px 0px;
      }

      #logout {
          background-image: image(url("icons/logout.png"));
          border-radius: 0px 0px 0px 0px;
          margin: 10px 0px 0px 0px;
      }

      #suspend {
          background-image: image(url("icons/suspend.png"));
          border-radius: 0px 0px 0px 0px;
          margin: 0px 0px 10px 0px;
      }

      #hibernate {
          background-image: image(url("icons/hibernate.png"));
          border-radius: 0px 0px 10px 0px;
          margin: 0px 10px 10px 0px;
      }

      #shutdown {
          background-image: image(url("icons/shutdown.png"));
          border-radius: 10px 0px 0px 0px;
          margin: 10px 0px 0px 10px;
      }

      #reboot {
          background-image: image(url("icons/reboot.png"));
          border-radius: 0px 0px 0px 10px;
          margin: 0px 0px 10px 10px;
      }
    '';
  };
  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
}
