{ ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      control-center-width = 500;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      widget-config = {
        title = {
          text = "Notification Center";
          clear-all-button = true;
          button-text = "󰆴 Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = "Notification Center";
        };
        mpris = {
          image-size = 96;
          image-radius = 7;
        };
        volume = {
          label = "󰕾";
        };
        backlight = {
          label = "󰃟";
        };
      };
      widgets = [
        "title"
        "mpris"
        "volume"
        "backlight"
        "dnd"
        "notifications"
      ];
    };
    style = ''
      * {
        font-family: JetBrainsMono Nerd Font Mono;
        font-weight: bold;
      }
      .control-center .notification-row:focus,
      .control-center .notification-row:hover {
        opacity: 0.95;
        background: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(12px);
      }
      .notification-row {
        outline: none;
        margin: 10px;
        padding: 0;
      }
      .notification {
        background: transparent;
        padding: 0;
        margin: 0px;
      }
      .notification-content {
        background: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(12px);
        padding: 10px;
        border-radius: 5px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        margin: 0;
      }
      .notification-default-action {
        margin: 0;
        padding: 0;
        border-radius: 5px;
      }
      .close-button {
        background: rgba(255, 70, 70, 0.8);
        color: rgba(255, 255, 255, 0.8);
        text-shadow: none;
        padding: 0;
        border-radius: 5px;
        margin-top: 5px;
        margin-right: 5px;
      }
      .close-button:hover {
        box-shadow: none;
        background: rgba(255, 100, 100, 0.9);
        transition: all .15s ease-in-out;
        border: none
      }
      .notification-action {
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-top: none;
        border-radius: 5px;
      }
      .notification-default-action:hover,
      .notification-action:hover {
        background: rgba(255, 255, 255, 0.1);
      }
      .notification-default-action {
        border-radius: 5px;
        margin: 0px;
      }
      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 7px;
        border-bottom-right-radius: 7px
      }
      .notification-action:first-child {
        border-bottom-left-radius: 10px;
        background: rgba(0, 0, 0, 0.5)
      }
      .notification-action:last-child {
        border-bottom-right-radius: 10px;
        background: rgba(0, 0, 0, 0.5)
      }
      .inline-reply {
        margin-top: 8px
      }
      .inline-reply-entry {
        background: rgba(0, 0, 0, 0.5);
        color: rgba(220, 220, 220, 0.9);
        caret-color: rgba(220, 220, 220, 0.9);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 5px
      }
      .inline-reply-button {
        margin-left: 4px;
        background: rgba(0, 0, 0, 0.5);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 5px;
        color: rgba(220, 220, 220, 0.9)
      }
      .inline-reply-button:disabled {
        background: initial;
        color: rgba(150, 150, 150, 0.5);
        border: 1px solid transparent
      }
      .inline-reply-button:hover {
        background: rgba(255, 255, 255, 0.1)
      }
      .body-image {
        margin-top: 6px;
        background-color: rgba(200, 200, 200, 0.1);
        border-radius: 5px
      }
      .summary {
        font-size: 16px;
        font-weight: 700;
        background: transparent;
        color: rgba(200, 200, 200, 0.9);
        text-shadow: none
      }
      .time {
        font-size: 16px;
        font-weight: 700;
        background: transparent;
        color: rgba(180, 180, 180, 0.8);
        text-shadow: none;
        margin-right: 18px
      }
      .body {
        font-size: 15px;
        font-weight: 400;
        background: transparent;
        color: rgba(220, 220, 220, 0.9);
        text-shadow: none
      }
      .control-center {
        background: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 5px;
      }
      .control-center-list {
        background: transparent
      }
      .control-center-list-placeholder {
        opacity: .5
      }
      .floating-notifications {
        background: transparent
      }
      .blank-window {
        background: alpha(black, 0)
      }
      .widget-title {
        color: rgba(255, 255, 255, 0.8);
        background: rgba(0, 0, 0, 0.3);
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        font-size: 1.5rem;
        border-radius: 5px;
      }
      .widget-title>button {
        font-size: 1rem;
        color: rgba(255, 255, 255, 0.8);
        text-shadow: none;
        background: rgba(0, 0, 0, 0.3);
        box-shadow: none;
        border-radius: 5px;
      }
      .widget-title>button:hover {
        background: rgba(255, 70, 70, 0.8);
        color: rgba(220, 220, 220, 0.9);
      }
      .widget-dnd {
        background: rgba(0, 0, 0, 0.3);
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: large;
        color: rgba(255, 255, 255, 0.8);
      }
      .widget-dnd>switch {
        border-radius: 5px;
        background: rgba(150, 150, 150, 0.5); // Updated for better contrast
      }
      .widget-dnd>switch:checked {
        background: rgba(255, 70, 70, 0.8);
        border: 1px solid rgba(255, 70, 70, 0.9);
      }
      .widget-dnd>switch slider {
        background: rgba(200, 200, 200, 0.8); // Updated for better visibility
        border-radius: 5px;
      }
      .widget-dnd>switch:checked slider {
        background: rgba(40, 40, 40, 0.9);
        border-radius: 5px;
      }
      .widget-label {
          margin: 10px 10px 5px 10px;
      }
      .widget-label>label {
        font-size: 1rem;
        color: rgba(220, 220, 220, 0.9);
      }
      .widget-mpris {
        color: rgba(255, 255, 255, 0.8);
        background: rgba(0, 0, 0, 0.3);
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
      }
      .widget-mpris > box > button {
        border-radius: 5px;
      }
      .widget-mpris-player {
        padding: 5px 10px;
        margin: 10px
      }
      .widget-mpris-title {
        font-weight: 700;
        font-size: 1.25rem
      }
      .widget-mpris-subtitle {
        font-size: 1.1rem
      }
      .widget-menubar>box>.menu-button-bar>button {
        border: none;
        background: transparent
      }
      .topbar-buttons>button {
        border: none;
        background: transparent
      }
      .widget-volume {
        background: rgba(0, 0, 0, 0.3);
        padding: 5px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: x-large;
        color: rgba(255, 255, 255, 0.8);
      }
      .widget-volume>box>button {
        background: rgba(150, 150, 150, 0.5);
        border: none
      }
      .per-app-volume {
        background-color: rgba(0, 0, 0, 0.3);
        padding: 4px 8px 8px;
        margin: 0 8px 8px;
        border-radius: 5px;
      }
      .widget-backlight {
        background: rgba(0, 0, 0, 0.3);
        padding: 5px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: x-large;
        color: rgba(255, 255, 255, 0.8);
      }
    '';
  };
}
