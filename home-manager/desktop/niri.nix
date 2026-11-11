{ ... }:
{
  wayland.windowManager.niri = {
    enable = true;
    # NixOS owns portal routing; niri uses GNOME screencasting and GTK file picking.
    portalPackage = null;

    settings = {
      prefer-no-csd = { };

      environment.DISPLAY = ":0";

      input = {
        keyboard = {
          repeat-rate = 35;
          repeat-delay = 200;
          numlock = { };
        };
        touchpad = {
          tap = { };
          natural-scroll = { };
        };
        focus-follows-mouse._props.max-scroll-amount = "0%";
      };

      layout = {
        gaps = 16;
        center-focused-column = "never";

        preset-column-widths._children = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        default-column-width.proportion = 0.5;

        focus-ring = {
          width = 4;
          active-color = "#ffb691";
          inactive-color = "#131313";
          urgent-color = "#ffb4ab";
        };

        shadow = {
          on = { };
          softness = 30;
          spread = 5;
          offset._props = {
            x = 0;
            y = 5;
          };
          color = "#00000070";
        };

        tab-indicator = {
          active-color = "#ffb691";
          inactive-color = "#783100";
          urgent-color = "#ffb4ab";
        };

        insert-hint.color = "#ffb69180";
      };

      screenshot-path = "~/Imágenes/Capturas de pantalla/Screenshot from %Y-%m-%d %H-%M-%S.png";

      _children = [
        { spawn-sh-at-startup = "noctalia"; }
        { spawn-sh-at-startup = "XMODIFIERS='' GTK_IM_MODULE='gtk-im-context-simple' doom emacs --daemon"; }
        {
          output = {
            _args = [ "eDP-1" ];
            mode = "1920x1080@120.030";
            scale = 1.0;
            transform = "normal";
            position._props = {
              x = 1280;
              y = 0;
            };
          };
        }
        {
          window-rule._children = [
            {
              match._props.app-id = "^org\\.wezfurlong\\.wezterm$";
              default-column-width = { };
            }
          ];
        }
        {
          window-rule._children = [
            {
              match._props = {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              };
              open-floating = true;
            }
          ];
        }
        {
          window-rule = {
            geometry-corner-radius = 20.0;
            clip-to-geometry = true;
          };
        }
        {
          window-rule._children = [
            { match._props.app-id = "dev.noctalia.Noctalia.settings"; }
            { open-floating = true; }
            { default-column-width.fixed = 1080; }
            { default-window-height.fixed = 920; }
          ];
        }
        {
          window-rule._children = [
            {
              match._props = {
                app-id = "steam";
                title = "^notificationtoasts_\\d+_desktop$";
              };
            }
            {
              default-floating-position = {
                _props = {
                  x = 10;
                  y = 10;
                  relative-to = "bottom-right";
                };
              };
            }
          ];
        }
        {
          window-rule._children = [
            { match._props.title = "launcher"; }
            { open-floating = true; }
            { default-column-width.fixed = 600; }
            { default-window-height.fixed = 480; }
          ];
        }
        {
          window-rule._children = [
            { match._props.title = "otter"; }
            { open-floating = true; }
            { default-column-width.fixed = 600; }
            { default-window-height.fixed = 480; }
          ];
        }
        {
          layer-rule._children = [
            { match._props.namespace = "^noctalia-backdrop*"; }
            { place-within-backdrop = true; }
          ];
        }
      ];

      binds = {
        "Mod+Shift+Slash".show-hotkey-overlay = { };

        "Mod+E" = {
          _props.hotkey-overlay-title = "Open a Terminal: ghostty";
          spawn = [ "kitty" ];
        };
        "Mod+Y" = {
          _props.hotkey-overlay-title = "Open file explorer";
          spawn-sh = "kitty yazi";
        };
        "Mod+B" = {
          _props.hotkey-overlay-title = "Open system monitor";
          spawn-sh = "kitty btop";
        };
        "Mod+M" = {
          _props.hotkey-overlay-title = "Open volume mixer";
          spawn-sh = "kitty ncpamixer";
        };
        "Mod+Shift+B" = {
          _props.hotkey-overlay-title = "Lock screen";
          spawn-sh = "noctalia msg session lock";
        };
        "Alt+Space".spawn = [ "noctalia" "msg" "panel-open" "launcher" ];

        "Super+Alt+S" = {
          _props = {
            allow-when-locked = true;
            hotkey-overlay-title = null;
          };
          spawn-sh = "pkill orca || exec orca";
        };

        "XF86AudioRaiseVolume" = {
          _props.allow-when-locked = true;
          spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
        };
        "XF86AudioLowerVolume" = {
          _props.allow-when-locked = true;
          spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        };
        "XF86AudioMute" = {
          _props.allow-when-locked = true;
          spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        "XF86AudioMicMute" = {
          _props.allow-when-locked = true;
          spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

        "XF86AudioPlay" = {
          _props.allow-when-locked = true;
          spawn-sh = "playerctl play-pause";
        };
        "XF86AudioStop" = {
          _props.allow-when-locked = true;
          spawn-sh = "playerctl stop";
        };
        "XF86AudioPrev" = {
          _props.allow-when-locked = true;
          spawn-sh = "playerctl previous";
        };
        "XF86AudioNext" = {
          _props.allow-when-locked = true;
          spawn-sh = "playerctl next";
        };

        "XF86MonBrightnessUp" = {
          _props.allow-when-locked = true;
          spawn = [ "noctalia" "msg" "brightness-up" ];
        };
        "XF86MonBrightnessDown" = {
          _props.allow-when-locked = true;
          spawn = [ "noctalia" "msg" "brightness-down" ];
        };

        "Mod+O" = {
          _props.repeat = false;
          toggle-overview = { };
        };

        "Mod+Shift+Q" = {
          _props.repeat = false;
          close-window = { };
        };

        "Mod+Space".spawn-sh = "noctalia msg panel-toggle control-center";

        "Mod+Left".focus-column-left = { };
        "Mod+Down".focus-window-down = { };
        "Mod+Up".focus-window-up = { };
        "Mod+Right".focus-column-right = { };
        "Mod+H".focus-column-left = { };
        "Mod+J".focus-window-down = { };
        "Mod+K".focus-window-up = { };
        "Mod+L".focus-column-right = { };

        "Mod+Ctrl+Left".move-column-left = { };
        "Mod+Ctrl+Down".move-window-down = { };
        "Mod+Ctrl+Up".move-window-up = { };
        "Mod+Ctrl+Right".move-column-right = { };
        "Mod+Ctrl+H".move-column-left = { };
        "Mod+Ctrl+J".move-window-down = { };
        "Mod+Ctrl+K".move-window-up = { };
        "Mod+Ctrl+L".move-column-right = { };

        "Mod+Home".focus-column-first = { };
        "Mod+End".focus-column-last = { };
        "Mod+Ctrl+Home".move-column-to-first = { };
        "Mod+Ctrl+End".move-column-to-last = { };

        "Mod+Shift+Left".focus-monitor-left = { };
        "Mod+Shift+Down".focus-monitor-down = { };
        "Mod+Shift+Up".focus-monitor-up = { };
        "Mod+Shift+Right".focus-monitor-right = { };
        "Mod+Shift+H".focus-monitor-left = { };
        "Mod+Shift+J".focus-monitor-down = { };
        "Mod+Shift+K".focus-monitor-up = { };
        "Mod+Shift+L".focus-monitor-right = { };

        "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = { };
        "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = { };
        "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = { };
        "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = { };
        "Mod+Shift+Ctrl+H".move-column-to-monitor-left = { };
        "Mod+Shift+Ctrl+J".move-column-to-monitor-down = { };
        "Mod+Shift+Ctrl+K".move-column-to-monitor-up = { };
        "Mod+Shift+Ctrl+L".move-column-to-monitor-right = { };

        "Mod+Page_Down".focus-workspace-down = { };
        "Mod+Page_Up".focus-workspace-up = { };
        "Mod+U".focus-workspace-down = { };
        "Mod+I".focus-workspace-up = { };
        "Mod+Ctrl+Page_Down".move-column-to-workspace-down = { };
        "Mod+Ctrl+Page_Up".move-column-to-workspace-up = { };
        "Mod+Ctrl+U".move-column-to-workspace-down = { };
        "Mod+Ctrl+I".move-column-to-workspace-up = { };

        "Mod+Shift+Page_Down".move-workspace-down = { };
        "Mod+Shift+Page_Up".move-workspace-up = { };
        "Mod+Shift+U".move-workspace-down = { };
        "Mod+Shift+I".move-workspace-up = { };

        "Mod+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          focus-workspace-up = { };
        };
        "Mod+Ctrl+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          move-column-to-workspace-up = { };
        };

        "Mod+WheelScrollRight".focus-column-right = { };
        "Mod+WheelScrollLeft".focus-column-left = { };
        "Mod+Ctrl+WheelScrollRight".move-column-right = { };
        "Mod+Ctrl+WheelScrollLeft".move-column-left = { };

        "Mod+Shift+WheelScrollDown".focus-column-right = { };
        "Mod+Shift+WheelScrollUp".focus-column-left = { };
        "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = { };
        "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = { };

        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;
        "Mod+Shift+1".move-column-to-workspace = 1;
        "Mod+Shift+2".move-column-to-workspace = 2;
        "Mod+Shift+3".move-column-to-workspace = 3;
        "Mod+Shift+4".move-column-to-workspace = 4;
        "Mod+Shift+5".move-column-to-workspace = 5;
        "Mod+Shift+6".move-column-to-workspace = 6;
        "Mod+Shift+7".move-column-to-workspace = 7;
        "Mod+Shift+8".move-column-to-workspace = 8;
        "Mod+Shift+9".move-column-to-workspace = 9;

        "Mod+BracketLeft".consume-or-expel-window-left = { };
        "Mod+BracketRight".consume-or-expel-window-right = { };

        "Mod+Comma".consume-window-into-column = { };
        "Mod+Period".expel-window-from-column = { };

        "Mod+R".switch-preset-column-width = { };
        "Mod+Shift+R".switch-preset-window-height = { };
        "Mod+Ctrl+R".reset-window-height = { };
        "Mod+F".maximize-column = { };
        "Mod+Shift+F".fullscreen-window = { };
        "Mod+Ctrl+F".expand-column-to-available-width = { };

        "Mod+C".center-column = { };
        "Mod+Ctrl+C".center-visible-columns = { };

        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";
        "Mod+Shift+Minus".set-window-height = "-10%";
        "Mod+Shift+Equal".set-window-height = "+10%";

        "Mod+V".toggle-window-floating = { };
        "Mod+Shift+V".switch-focus-between-floating-and-tiling = { };

        "Mod+W".toggle-column-tabbed-display = { };

        "Print".screenshot = { };
        "Ctrl+Print".screenshot-screen = { };
        "Alt+Print".screenshot-window = { };

        "Mod+Escape" = {
          _props.allow-inhibiting = false;
          toggle-keyboard-shortcuts-inhibit = { };
        };

        "Mod+Shift+E".quit = { };
        "Ctrl+Alt+Delete".quit = { };

        "Mod+Shift+P".power-off-monitors = { };
      };

      switch-events.lid-close.spawn = [ "noctalia" "msg" "session" "lock" ];
    };
  };
}
