{ ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "bottom";
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
          text = "";
          clear-all-button = true;
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = "Notifications";
        };
        mpris = {
          image-size = 96;
          image-radius = 7;
        };
        volume = {
          label = "󰕾";
        };
      };
      widgets = [
        "mpris"
        "volume"
        "dnd"
        "notifications"
        "title"
      ];
    };
    style = ''
      /* ── Color Palette & Variables ────────────────────────────── */
      @define-color text_primary rgba(248, 248, 252, 0.98);
      @define-color text_secondary rgba(215, 220, 225, 0.78);
      @define-color bg_primary rgba(89, 89, 110, 0.15);
      @define-color bg_secondary rgba(72, 72, 72, 0.25);
      @define-color bg_hover rgba(210, 215, 225, 0.15);
      @define-color accent rgba(10, 132, 255, 0.8);
      @define-color border_medium rgba(255, 255, 255, 0.04);
      @define-color close_bg rgba(255, 70, 70, 0.8);
      @define-color close_hover rgba(255, 100, 100, 0.9);

      /* ── Base Styles ─────────────────────────────────────────── */
      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        color: @text_primary;
        border: none;
        background: none;
        margin: 0;
        padding: 0;
      }

      /* ── Control Center ───────────────────────────────────────── */
      .control-center {
        background: @bg_primary;
        border: 1px solid @border_medium;
        border-radius: 16px;
        padding: 12px;
        min-width: 380px;
      }

      .control-center-list {
        background: transparent;
        padding: 0;
      }

      /* ── Widgets ────────────────────────────────────────────── */
      .widget-volume,
      .widget-mpris,
      .widget-dnd,
      .widget-title {
        background: @bg_secondary;
        border: 1px solid @border_medium;
        border-radius: 12px;
        padding: 10px;
        margin: 0 0 6px 0;
      }

      /* DND Widget */
      .widget-dnd {
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .widget-dnd > switch {
        background: @bg_secondary;
        border-radius: 12px;
        min-width: 40px;
      }

      .widget-dnd > switch:checked {
        background: @accent;
      }

      .widget-dnd > switch slider {
        background: @text_primary;
        border-radius: 50%;
        min-width: 20px;
        min-height: 20px;
      }

      /* Clear All Button */
      #clear-all-button {
        background: @bg_secondary;
        border-radius: 8px;
        padding: 6px;
        color: @text_secondary;
        transition: all 0.2s ease;
        width: 100%;
        margin: 4px 0;
      }

      #clear-all-button:hover {
        background: @bg_hover;
        color: @text_primary;
      }

      /* Title */
      .title {
        font-weight: bold;
        background: @bg_secondary;
        border-radius: 12px;
        padding: 8px;
        margin-bottom: 8px;
      }

      /* MPRIS Widget */
      .widget-mpris-player {
        background: @bg_secondary;
        border-radius: 10px;
        padding: 8px;
      }

      .widget-mpris-title {
        font-weight: bold;
        color: @text_primary;
      }

      .widget-mpris-subtitle {
        color: @text_secondary;
      }

      .widget-mpris button {
        background: @bg_secondary;
        border-radius: 50%;
        min-width: 32px;
        min-height: 32px;
        padding: 4px;
        color: @text_secondary;
        transition: all 0.2s ease;
      }

      .widget-mpris button:hover {
        background: @bg_hover;
        color: @text_primary;
      }

      /* Volume Widget */
      .widget-volume > box {
        margin: 0 8px;
      }

      .widget-volume > box > button {
        background: @bg_secondary;
        border-radius: 8px;
        min-width: 24px;
        min-height: 24px;
        margin-right: 8px;
      }

      /* Sliders */
      scale trough {
        background-color: @bg_secondary;
        border-radius: 5px;
        min-height: 4px;
      }

      scale trough highlight {
        background-color: @accent;
        border-radius: 5px;
      }

      scale slider {
        background-color: @text_primary;
        border-radius: 50%;
        min-width: 12px;
        min-height: 12px;
        margin: -4px;
      }

      /* ── Notifications ───────────────────────────────────────── */
      .notification {
        background: @bg_secondary;
        border: 1px solid @border_medium;
        border-radius: 12px;
        padding: 8px;
        margin: 4px 0;
        transition: all 0.2s ease;
      }

      .notification:hover {
        background: @bg_hover;
      }

      .notification-content {
        margin: 4px;
      }

      .summary {
        font-weight: bold;
        color: @text_primary;
      }

      .time {
        color: @text_secondary;
        margin: 0 6px;
      }

      .body {
        color: @text_secondary;
      }

      .close-button {
        background: @close_bg;
        border-radius: 50%;
        min-width: 22px;
        min-height: 22px;
        color: @text_primary;
      }

      .close-button:hover {
        background: @close_hover;
      }

      .notification-action {
        background: @bg_secondary;
        border-radius: 8px;
        margin: 4px;
        padding: 4px 8px;
        color: @text_secondary;
        transition: all 0.2s ease;
      }

      .notification-action:hover {
        background: @bg_hover;
        color: @text_primary;
      }
    '';
  };
}
