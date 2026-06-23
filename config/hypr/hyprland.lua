local terminal = "kitty"
local fileManager = "thunar"
local menu = "fuzzel"
local altmenu = "fuzzel"
local mainMod = "SUPER"

local HOME = os.getenv("HOME") or "~"
local pic_dir = HOME .. "/mysticism/i/screens"

local function sh(command)
  return hl.dsp.exec_cmd(command)
end

local function set_layout(layouts)
  hl.config({ input = { kb_layout = layouts } })
end

-- ──────────────
-- 🖥️ Autostart
-- ──────────────

hl.on("hyprland.start", function()
  hl.exec_cmd("uwsm finalize WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP")

  hl.exec_cmd("uwsm app -- hypridle")
  hl.exec_cmd("uwsm app -- xrandr --output DP-1 --primary")
  hl.dispatch(hl.dsp.focus({ workspace = 1 }))
  hl.exec_cmd("uwsm app -- bash ~/.config/hypr/start.sh")

  hl.exec_cmd("fcitx5-remote -r")
  hl.exec_cmd("fcitx5 -d --replace")
  hl.exec_cmd("fcitx5-remote -r")
end)

-- ──────────────
-- 🖥️ Applications
-- ──────────────

hl.bind("SUPER + O", sh("pkill fuzzel || cliphist list | uwsm app -- fuzzel --dmenu | cliphist decode | wl-copy"))
hl.bind("SUPER + N", sh("uwsm app -- makoctl menu -- fuzzel --dmenu"))
hl.bind("SUPER + SHIFT + C", sh("uwsm app -- hyprpicker -a"))

-- Zoom around cursor.
local zoom_factor = 1.0
local zoom_step = math.sqrt(2)

hl.bind("SUPER + mouse_down", function()
  zoom_factor = zoom_factor * zoom_step
  hl.config({ cursor = { zoom_factor = zoom_factor } })
end)

hl.bind("SUPER + mouse_up", function()
  zoom_factor = math.max(1.0, zoom_factor / zoom_step)
  hl.config({ cursor = { zoom_factor = zoom_factor } })
end)

hl.bind("SUPER + mouse:274", function()
  zoom_factor = 1.0
  hl.config({ cursor = { zoom_factor = zoom_factor } })
end)

-- ──────────────
-- 🌐 Language and Keyboard
-- ──────────────

hl.config({
  input = {
    kb_layout = "us,ua",
    kb_options = "grp:caps_toggle",
    follow_mouse = 1,
    special_fallthrough = true,
    sensitivity = 0,

    touchpad = {
      natural_scroll = true,
      disable_while_typing = true,
      clickfinger_behavior = true,
      scroll_factor = 0.5,
    },
  },
})

-- fcitx helpers
hl.bind("F1", function()
  hl.exec_cmd("fcitx5-remote -c")
  set_layout("us,ua")
end)

hl.bind("F2", function()
  set_layout("us")
  hl.exec_cmd("fcitx5-remote -o")
end)

hl.bind("SHIFT + ALT + CTRL + F2", function()
  hl.exec_cmd("fcitx5-remote -c")
  set_layout("gr")
end)

-- ──────────────
-- 🔧 Bindings
-- ──────────────

-- Window navigation
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

-- Window resizing submap
hl.bind("ALT + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
  hl.bind("l", hl.dsp.window.resize({ x = 30,  y = 0,   relative = true }), { repeating = true })
  hl.bind("h", hl.dsp.window.resize({ x = -30, y = 0,   relative = true }), { repeating = true })
  hl.bind("k", hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), { repeating = true })
  hl.bind("j", hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), { repeating = true })
  hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Actions
hl.bind(mainMod .. " + Return", sh("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + T", sh("uwsm app -- " .. terminal))
hl.bind("ALT + T", sh("uwsm app -- " .. terminal))

hl.bind(mainMod .. " + E", sh("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + SHIFT + Q", sh("~/.config/hypr/kill.sh"))

hl.bind(mainMod .. " + SHIFT + R", sh("hyprctl reload"))

hl.bind(mainMod .. " + SHIFT + E", sh("uwsm stop"))
hl.bind(mainMod .. " + SHIFT + M", sh("uwsm app -- hyprlock"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Workspaces
hl.bind(mainMod .. " + W", hl.dsp.focus({ workspace = "name:web" }))

for i = 1, 10 do
  local key = tostring(i % 10) -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

for i = 11, 20 do
  local key = tostring(i - 10)
  if key == "10" then key = "0" end
  hl.bind("ALT + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind("ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Fullscreen
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mainMod .. " + D", sh("uwsm app -- " .. menu))
hl.bind("ALT + space", sh("uwsm app -- " .. altmenu))

-- ──────────────
-- 📸 Screenshots / Recording / OCR
-- ──────────────

local scr_area = ([=[
file="%s/scr-$(date +%%F_%%T).png";
grim -g "$(slurp)" - | magick - -shave 1x1 PNG:- | wl-copy &&
wl-paste > "$file" &&
swappy -f "$file" -o "${file}-annotated.png"
]=]):format(pic_dir)

local scr_full = ([=[
grim - | wl-copy && wl-paste > "%s/scr-$(date +%%F_%%T).png"
]=]):format(pic_dir)

hl.bind("SUPER + P", sh(scr_area))

local rec_area_toggle = ([=[
pkill -INT wf-recorder || wf-recorder -g "$(slurp)" -f "%s/rec-$(date +%%F_%%T).mp4"
]=]):format(pic_dir)

hl.bind("SUPER + R", sh(rec_area_toggle))

local ocr_area = ([=[
file="%s/scr-$(date +%%F_%%T)_OCRed.png";
grim -g "$(slurp)" - | magick - -shave 1x1 PNG:- | wl-copy &&
wl-paste > "$file" &&
tesseract "$file" - | wl-copy
]=]):format(pic_dir)

hl.bind("ALT + SHIFT + T", sh(ocr_area))

-- ──────────────
-- 🎵 Media Controls
-- ──────────────

hl.bind(mainMod .. " + M", sh("uwsm app -- mpc toggle"))
hl.bind(mainMod .. " + SHIFT + N", sh("uwsm app -- mu next"))
hl.bind(mainMod .. " + SHIFT + P", sh("uwsm app -- mu prev"))
hl.bind(mainMod .. " + SHIFT + D", sh("uwsm app -- mu del"))

hl.bind("XF86AudioNext", sh('uwsm app -- playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`'), { locked = true })
hl.bind("SUPER + SHIFT + B", sh("uwsm app -- playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", sh("uwsm app -- playerctl play-pause"), { locked = true })

-- Audio
hl.bind("ALT + XF86AudioMute", sh("uwsm app -- wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
hl.bind("SUPER + XF86AudioMute", sh("uwsm app -- wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioMute", sh("uwsm app -- wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"), { locked = true })
hl.bind("XF86AudioRaiseVolume", sh("uwsm app -- wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", sh("uwsm app -- wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", sh("uwsm app -- brightnessctl s +5%"))
hl.bind("XF86MonBrightnessDown", sh("uwsm app -- brightnessctl s 5%-"))

hl.bind("XF86KbdBrightnessUp", sh("uwsm app -- brightnessctl -d '*::kbd_backlight' set +33%"))
hl.bind("SUPER + XF86KbdBrightnessDown", sh("uwsm app -- brightnessctl -d '*::kbd_backlight' set 33%-"))

-- Turn off laptop display on lid close.
-- DPMS directly in a bind is discouraged, so this uses a tiny timer.
local function delayed_dpms(action)
  return function()
    hl.timer(function()
      hl.dispatch(hl.dsp.dpms({ action = action }))
    end, { timeout = 500, type = "oneshot" })
  end
end

hl.bind("switch:on:Lid Switch", delayed_dpms("disable"), { locked = true })
hl.bind("switch:off:Lid Switch", delayed_dpms("enable"), { locked = true })

-- ──────────────
-- 🖥️ Rendering
-- ──────────────

hl.monitor({ output = "DP-2",     mode = "3840x2160@120", position = "0x0",       scale = 1, transform = 0, bitdepth = 10 }) -- main screens: 1, 3, 4, 17
hl.monitor({ output = "DP-1",     mode = "3840x2160@60",  position = "auto-left",  scale = 1, transform = 1, bitdepth = 10 }) -- secondary screens: 2, 5
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@120", position = "auto-right", scale = 1, transform = 0, bitdepth = 10 }) -- TV screens: nothing assigned
hl.monitor({ output = "HDMI-A-2", mode = "1600x1200@60",  position = "auto-down", scale = 1, transform = 0, bitdepth = 10 }) -- eInk screens: 10, 13

local workspace_monitor_rules = {
  { monitor = "DP-2", workspaces = { 1, 3, 4, 17 } },
  { monitor = "DP-1", workspaces = { 2, 5, 8 } },
  { monitor = "HDMI-A-2", workspaces = { 10, 13 } },
}

for _, rule in ipairs(workspace_monitor_rules) do
  for index, workspace in ipairs(rule.workspaces) do
    hl.workspace_rule({
      workspace = tostring(workspace),
      monitor = rule.monitor,
      default = index == 1,
      persistent = true,
    })
  end
end

-- hl.monitor({ output = "DP-1", disabled = true })
hl.monitor({ output = "HDMI-A-1", disabled = true })
hl.monitor({ output = "HDMI-A-2", disabled = true })

hl.config({
  opengl = {
    nvidia_anti_flicker = true,
  },
})

-- ──────────────
-- 🎨 Visual Settings
-- ──────────────

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 0,
    col = {
      active_border = { colors = { "rgba(ff00ffee)", "rgba(8a2be2ee)" }, angle = 45 },
      inactive_border = "rgba(c070d088)",
    },
    layout = "dwindle",
    allow_tearing = true,
  },

  decoration = {
    rounding = 10,
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
    },
  },

  animations = {
    enabled = true,
  },

  misc = {
    force_default_wallpaper = 0,
    vrr = 1,
    on_focus_under_fullscreen = 2,
    allow_session_lock_restore = true,
    initial_workspace_tracking = 0,
  },
})

-- No shadow for tiled windows
hl.window_rule({
  name = "windowrule-1",
  match = { float = false },
  no_shadow = true,
})

-- Animations
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

-- ──────────────
-- 🪟 Window Rules
-- ──────────────

hl.window_rule({
  name = "windowrule-2",
  match = { class = "(dev.warp.Warp)" },
  tile = true,
})

hl.window_rule({
  name = "windowrule-3",
  match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
  float = true,
})

-- Dialogs
hl.window_rule({ name = "windowrule-4",  match = { title = "^(Open File)(.*)$" },        float = true })
hl.window_rule({ name = "windowrule-5",  match = { title = "^(Select a File)(.*)$" },    float = true })
hl.window_rule({ name = "windowrule-6",  match = { title = "^(Choose wallpaper)(.*)$" }, float = true })
hl.window_rule({ name = "windowrule-7",  match = { title = "^(Open Folder)(.*)$" },      float = true })
hl.window_rule({ name = "windowrule-8",  match = { title = "^(Save As)(.*)$" },          float = true })
hl.window_rule({ name = "windowrule-9",  match = { title = "^(Library)(.*)$" },          float = true })
hl.window_rule({ name = "windowrule-10", match = { title = "^(File Upload)(.*)$" },      float = true })

-- ──────────────
-- 📐 Layer Rules
-- ──────────────
hl.layer_rule({ match = { namespace = ".*" }, xray = true })
hl.layer_rule({ match = { namespace = "launcher" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true, ignore_alpha = 0.69 })
hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })

-- Workaround: make screensharing for X apps work
hl.window_rule({
  name = "xwayland-video-bridge-fixes",
  match = { class = "xwaylandvideobridge" },
  no_initial_focus = true,
  no_focus = true,
  no_anim = true,
  no_blur = true,
  max_size = { 1, 1 },
  opacity = "0.0 override",
})
