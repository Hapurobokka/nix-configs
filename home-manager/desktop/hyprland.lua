local mod      = "SUPER"
local terminal = "kitty"
local fileMgr  = "kitty yazi"
local ipc      = "noctalia msg"
local web      = "firefox"
local volume   = "kitty ncpamixer"
local blue     = "kitty bluetui"

hl.config({
  general = {
    layout   = "scrolling",
    gaps_in  = 5,
    gaps_out = 10,
  },
  scrolling = {
    column_width             = 0.5,
    fullscreen_on_one_column = true,
    follow_focus             = true,
    wrap_focus               = true,
    direction                = "right",
    explicit_column_widths   = "0.5, 1.0",
  },
  decoration = {
    rounding       = 20,
    rounding_power = 2,
    shadow = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = "0xee1a1a1a",
    },
    blur = {
      enabled  = true,
      size     = 3,
      passes   = 2,
      vibrancy = 0.1696,
    },
  },
  input = {
    kb_layout    = "latam",
    follow_mouse = 1,
    sensitivity  = 0,
    touchpad = {
      natural_scroll = false,
    },
  },
  animations = {
    enabled = true,
  },
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 3,
  bezier = "default",
  style = "slidevert"
})

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 6,
  bezier = "default",
  style = "slide"
})

hl.monitor({
  output   = "",
  mode     = "highres",
  position = "auto",
  scale    = 1,
})

-- Focus
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mod .. " + CTRL + H", hl.dsp.layout("swapcol l"))
hl.bind(mod .. " + CTRL + L", hl.dsp.layout("swapcol r"))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + comma", hl.dsp.layout("expel"))
hl.bind(mod .. " + period", hl.dsp.layout("consume"))

-- Mouse drag/resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces
for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Previous/next workspace
hl.bind(mod .. " + U", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + I", hl.dsp.focus({ workspace = "+1" }))

-- Scroll through workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move windows to workspace
for i = 1, 9 do
  hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Monitor switching
hl.bind(mod .. " + SHIFT + H", hl.dsp.focus({ monitor = "-1" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.focus({ monitor = "+1" }))

-- Special workspace (scratchpad)
hl.bind(mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Window actions
hl.bind(mod .. " + F",         hl.dsp.layout("colresize +conf"))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + D",         hl.dsp.window.pseudo())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + C", hl.dsp.exit())

-- Apps
hl.bind("ALT + Space",         hl.dsp.exec_cmd(ipc .. " panel-toggle launcher"))
hl.bind(mod .. " + Space",     hl.dsp.exec_cmd(ipc .. " panel-toggle control-center"))
hl.bind(mod .. " + E",         hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + T",         hl.dsp.exec_cmd(web))
hl.bind(mod .. " + Y",         hl.dsp.exec_cmd(fileMgr))
hl.bind(mod .. " + SHIFT + V", hl.dsp.exec_cmd(volume))
hl.bind(mod .. " + B",         hl.dsp.exec_cmd(blue))
hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd(ipc .. "session lock"))

-- Screenshots
hl.bind("Print",               hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mod .. " + PRINT",     hl.dsp.exec_cmd("hyprshot -m window"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume-up"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(ipc .. " volume-mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(ipc .. " brightness-up"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness-down"), { locked = true, repeating = true })

-- Media
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Window rules
-- hl.window_rule({
--   match          = { class = ".*" },
--   suppress_event = "maximize",
-- })

hl.window_rule({
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

hl.window_rule({
  match            = { class = "^(xwaylandvideobridge)$" },
  opacity          = "0.0",
  no_anim          = true,
  no_initial_focus = true,
  max_size         = "1 1",
  no_blur          = true,
  no_focus         = true,
})

-- Startup
hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
end)
