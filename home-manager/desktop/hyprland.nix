{ pkgs, config, lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  programs.hyprlock.enable = false;
  services.hypridle.enable = false;
  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      # ----- Lua local variables -----
      mod      = { _var = "SUPER"; };
      terminal = { _var = "kitty"; };
      fileMgr  = { _var = "kitty yazi"; };
      ipc      = { _var = "noctalia msg"; };
      web      = { _var = "vivaldi"; };
      volume   = { _var = "kitty ncpamixer"; };
      blue     = { _var = "kitty bluetui"; };

      # ----- hl.config({...}) wrapped settings -----
      config = {
        general = {
          layout   = "scrolling";
          gaps_in  = 5;
          gaps_out = 10;
        };

        scrolling = {
          column_width             = 0.5;
          fullscreen_on_one_column = true;
          follow_focus             = true;
          wrap_focus               = true;
        };

        decoration = {
          rounding       = 20;
          rounding_power = 2;

          shadow = {
            enabled      = true;
            range        = 4;
            render_power = 3;
            color        = "0xee1a1a1a";
          };

          blur = {
            enabled   = true;
            size      = 3;
            passes    = 2;
            vibrancy  = 0.1696;
          };
        };

        input = {
          kb_layout    = "latam";
          follow_mouse = 1;
          sensitivity  = 0;
          touchpad = {
            natural_scroll = false;
          };
        };
      };

      # ----- Monitor -----
      monitor = {
        output   = "";
        mode     = "highres";
        position = "auto";
        scale    = 1;
      };

      # ----- All binds -----
      bind = [
        # Alt + Space → noctalia launcher
        {
          _args = [
            "ALT + Space"
            (mkLuaInline "hl.dsp.exec_cmd(ipc .. \" panel-toggle launcher\")")
          ];
        }
        # SUPER + Space → noctalia control-center
        {
          _args = [
            (mkLuaInline "mod .. \" + Space\"")
            (mkLuaInline "hl.dsp.exec_cmd(ipc .. \" panel-toggle control-center\")")
          ];
        }
        # SUPER + comma → noctalia settings
        {
          _args = [
            (mkLuaInline "mod .. \" + comma\"")
            (mkLuaInline "hl.dsp.exec_cmd(ipc .. \" settings-toggle\")")
          ];
        }
        # Print → hyprshot region
        {
          _args = [
            "Print"
            (mkLuaInline "hl.dsp.exec_cmd(\"hyprshot -m region\")")
          ];
        }
        # SUPER + Print → hyprshot window
        {
          _args = [
            (mkLuaInline "mod .. \" + PRINT\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"hyprshot -m window\")")
          ];
        }
        # Movement: SUPER + HJKL
        {
          _args = [
            (mkLuaInline "mod .. \" + H\"")
            (mkLuaInline "hl.dsp.focus({ direction = \"left\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + L\"")
            (mkLuaInline "hl.dsp.focus({ direction = \"right\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + K\"")
            (mkLuaInline "hl.dsp.focus({ direction = \"up\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + J\"")
            (mkLuaInline "hl.dsp.focus({ direction = \"down\" })")
          ];
        }
        # Open web browser
        {
          _args = [
            (mkLuaInline "mod .. \" + T\"")
            (mkLuaInline "hl.dsp.exec_cmd(web)")
          ];
        }
        # Volume mixer
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + V\"")
            (mkLuaInline "hl.dsp.exec_cmd(volume)")
          ];
        }
        # Bluetooth
        {
          _args = [
            (mkLuaInline "mod .. \" + B\"")
            (mkLuaInline "hl.dsp.exec_cmd(blue)")
          ];
        }
        # File manager
        {
          _args = [
            (mkLuaInline "mod .. \" + Y\"")
            (mkLuaInline "hl.dsp.exec_cmd(fileMgr)")
          ];
        }
        # Fullscreen (set): SUPER + F
        {
          _args = [
            (mkLuaInline "mod .. \" + F\"")
            (mkLuaInline "hl.dsp.window.fullscreen({ action = \"set\" })")
          ];
        }
        # Fullscreen (unset): SUPER + SHIFT + F
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + F\"")
            (mkLuaInline "hl.dsp.window.fullscreen({ action = \"unset\" })")
          ];
        }
        # Open terminal
        {
          _args = [
            (mkLuaInline "mod .. \" + E\"")
            (mkLuaInline "hl.dsp.exec_cmd(terminal)")
          ];
        }
        # Lock screen
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + B\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"hyprlock\")")
          ];
        }
        # Kill active window
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + Q\"")
            (mkLuaInline "hl.dsp.window.close()")
          ];
        }
        # Exit Hyprland
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + C\"")
            (mkLuaInline "hl.dsp.exit()")
          ];
        }
        # Toggle floating
        {
          _args = [
            (mkLuaInline "mod .. \" + V\"")
            (mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
          ];
        }
        # Pseudo (dwindle)
        {
          _args = [
            (mkLuaInline "mod .. \" + D\"")
            (mkLuaInline "hl.dsp.window.pseudo()")
          ];
        }
        # Workspace switching: SUPER + 1-9,0
        {
          _args = [
            (mkLuaInline "mod .. \" + 1\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 1 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 2\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 2 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 3\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 3 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 4\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 4 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 5\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 5 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 6\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 6 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 7\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 7 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 8\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 8 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 9\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 9 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + 0\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 10 })")
          ];
        }
        # Move window to workspace: SUPER + SHIFT + 1-9,0
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 1\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 1 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 2\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 2 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 3\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 3 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 4\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 4 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 5\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 5 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 6\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 6 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 7\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 7 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 8\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 8 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 9\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 9 })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + 0\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 10 })")
          ];
        }
        # Special workspace (scratchpad)
        {
          _args = [
            (mkLuaInline "mod .. \" + S\"")
            (mkLuaInline "hl.dsp.workspace.toggle_special(\"magic\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + S\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = \"special:magic\" })")
          ];
        }
        # Scroll through workspaces
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse_down\"")
            (mkLuaInline "hl.dsp.focus({ workspace = \"e+1\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse_up\"")
            (mkLuaInline "hl.dsp.focus({ workspace = \"e-1\" })")
          ];
        }
        # Next/prev workspace (niri-style: U = down/prev, I = up/next)
        {
          _args = [
            (mkLuaInline "mod .. \" + U\"")
            (mkLuaInline "hl.dsp.focus({ workspace = \"-1\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + I\"")
            (mkLuaInline "hl.dsp.focus({ workspace = \"+1\" })")
          ];
        }
        # Move workspace left/right (monitor switching)
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + H\"")
            (mkLuaInline "hl.dsp.focus({ monitor = \"-1\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + L\"")
            (mkLuaInline "hl.dsp.focus({ monitor = \"+1\" })")
          ];
        }
        # Move windows: SUPER + CTRL + HJKL
        {
          _args = [
            (mkLuaInline "mod .. \" + CTRL + H\"")
            (mkLuaInline "hl.dsp.window.move({ direction = \"left\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + CTRL + L\"")
            (mkLuaInline "hl.dsp.window.move({ direction = \"right\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + CTRL + K\"")
            (mkLuaInline "hl.dsp.window.move({ direction = \"up\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + CTRL + J\"")
            (mkLuaInline "hl.dsp.window.move({ direction = \"down\" })")
          ];
        }
        # Mouse drag (was bindm)
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse:272\"")
            (mkLuaInline "hl.dsp.window.drag()")
            { mouse = true; }
          ];
        }
        # Mouse resize (was bindm)
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse:273\"")
            (mkLuaInline "hl.dsp.window.resize()")
            { mouse = true; }
          ];
        }
        # Media keys: volume → noctalia
        {
          _args = [
            "XF86AudioRaiseVolume"
            (mkLuaInline "hl.dsp.exec_cmd(ipc .. \" volume-up\")")
            { locked = true; repeating = true; }
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (mkLuaInline "hl.dsp.exec_cmd(ipc .. \" volume-down\")")
            { locked = true; repeating = true; }
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (mkLuaInline "hl.dsp.exec_cmd(ipc .. \" volume-mute\")")
            { locked = true; repeating = true; }
          ];
        }
        {
          _args = [
            "XF86AudioMicMute"
            (mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")")
            { locked = true; repeating = true; }
          ];
        }
        # Media keys: brightness → noctalia
        {
          _args = [
            "XF86MonBrightnessUp"
            (mkLuaInline "hl.dsp.exec_cmd(ipc .. \" brightness-up\")")
            { locked = true; repeating = true; }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (mkLuaInline "hl.dsp.exec_cmd(ipc .. \" brightness-down\")")
            { locked = true; repeating = true; }
          ];
        }
        # Media player keys (was bindl)
        {
          _args = [
            "XF86AudioNext"
            (mkLuaInline "hl.dsp.exec_cmd(\"playerctl next\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPause"
            (mkLuaInline "hl.dsp.exec_cmd(\"playerctl play-pause\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPlay"
            (mkLuaInline "hl.dsp.exec_cmd(\"playerctl play-pause\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (mkLuaInline "hl.dsp.exec_cmd(\"playerctl previous\")")
            { locked = true; }
          ];
        }
      ];

      # ----- Window Rules -----
      window_rule = [
        # Suppress maximize events from apps
        {
          match = { class = ".*"; };
          suppress_event = "maximize";
        }
        # Fix XWayland dragging issues
        {
          match = {
            class      = "^$";
            title      = "^$";
            xwayland   = true;
            float      = true;
            fullscreen = false;
            pin        = false;
          };
          no_focus = true;
        }
        # XWayland video bridge
        {
          match = { class = "^(xwaylandvideobridge)$"; };
          opacity = "0.0";
          no_anim = true;
          no_initial_focus = true;
          max_size = "1 1";
          no_blur = true;
          no_focus = true;
        }
      ];

      # ----- Startup -----
      on = {
        _args = [
          "hyprland.start"
          (mkLuaInline ''
            function()
              hl.exec_cmd("noctalia")
            end
          '')
        ];
      };
    };
  };
}
