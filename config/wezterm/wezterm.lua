local wezterm = require "wezterm"
local config = wezterm.config_builder()

local alchemy = "A:\\"

config.default_prog = { "nu" }

-- behavior
config.disable_default_mouse_bindings = true
config.disable_default_key_bindings = true
config.default_cwd = alchemy
config.audible_bell = "Disabled"
config.scrollback_lines = 5000
config.unicode_version = 12
config.max_fps = 240
config.animation_fps = 240
-- switch when moved to dworak
-- config.quick_select_alphabet = "uhetaoqjkxpynsgcrlmwvzfidb"

-- theme
config.colors = {
  -- darkvoid color scheme base
  foreground = "#c0c0c0",
  background = "#040709",

  cursor_bg = "#c1c1c1",
  cursor_fg = "#090a04",
  cursor_border = "#7fbfff",
  selection_fg = "#c0c0c0",
  selection_bg = "#303030",
  scrollbar_thumb = "#404040",

  ansi = {
    "#1c1c1c",
    "#ff3131",
    "#66b2b2",
    "#d1d1d1",
    "#4b8902",
    "#b16286",
    "#1bfd9c",
    "#c0c0c0",
  },

  brights = {
    "#404040",
    "#fb4934",
    "#b8bb26",
    "#9efd84",
    "#83a598",
    "#d3869b",
    "#8ec07c",
    "#ebdbb2",
  },

  visual_bell = "#7fbfff",
  tab_bar = {
    background = "#1c1c1c",
    active_tab = {
      bg_color = "#303030",
      fg_color = "#c0c0c0",
    },
    inactive_tab = {
      bg_color = "#1c1c1c",
      fg_color = "#585858",
    },
    inactive_tab_hover = {
      bg_color = "#303030",
      fg_color = "#c0c0c0",
    },
  },
}

-- config.command_palette_bg_color = "#080808"
-- config.command_palette_fg_color = "#EAEAEA"

config.font_size = 12
config.line_height = 1
config.command_palette_font_size = 14
config.initial_cols = 200
config.initial_rows = 45
config.adjust_window_size_when_changing_font_size = false

-- window
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_frame = {
  border_top_height = 0,
  border_left_width = 0,
  border_right_width = 0,
  border_bottom_height = 0,
  border_left_color = "black",
  border_right_color = "black",
  border_bottom_color = "black",
  border_top_color = "black",
}

wezterm.on("window-config-reloaded", function(window, _)
  window:focus()
end)

-- custom state & actions
local Constants = {
  window_decorations = {
    default = config.window_decorations,
    zen = "NONE",
  },
}
local State = {
  virtual_full_screen = {},
}
local Actions = {
  ToggleVirtualFullScreen = wezterm.action_callback(function(window, _)
    local window_id = window:window_id()
    local overrides = window:get_config_overrides() or {}
    local is_virtual_full_screen = State.virtual_full_screen[window_id]

    if is_virtual_full_screen then
      overrides.window_decorations = Constants.window_decorations.default
      window:restore()
    else
      overrides.window_decorations = Constants.window_decorations.zen
      window:maximize()
    end

    window:set_config_overrides(overrides)
    State.virtual_full_screen[window_id] = not is_virtual_full_screen
  end),
}

-- keymap
config.keys = {
  {
    key = "Enter",
    mods = "ALT",
    action = Actions.ToggleVirtualFullScreen,
  },
  {
    key = "C",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CopyTo "Clipboard",
  },
  {
    key = "V",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PasteFrom "Clipboard",
  },
  {
    key = " ",
    mods = "CTRL",
    action = wezterm.action.SendKey {
      key = " ",
      mods = "CTRL",
    },
  },
  {
    key = "Enter",
    mods = "CTRL",
    action = wezterm.action.SendKey {
      key = "Enter",
      mods = "CTRL",
    },
  },
  {
    key = "Enter",
    mods = "SHIFT",
    action = wezterm.action.SendKey {
      key = "Enter",
      mods = "SHIFT",
    },
  },
  --
  {
    key = "v",
    mods = "ALT",
    action = wezterm.action.SplitPane {
      direction = "Right",
      size = { Percent = 50 },
    },
  },
  {
    key = "x",
    mods = "ALT",
    action = wezterm.action.SplitPane {
      direction = "Down",
      size = { Percent = 50 },
    },
  },
  {
    key = "h",
    mods = "ALT|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key = "j",
    mods = "ALT|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "ALT|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key = "l",
    mods = "ALT|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Right",
  },
  {
    key = "c",
    mods = "ALT",
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key = ";",
    mods = "ALT",
    action = wezterm.action.ActivateCommandPalette,
  },
  {
    key = "f",
    mods = "ALT",
    action = wezterm.action.QuickSelect,
  },
  {
    key = "0",
    mods = "ALT",
    action = wezterm.action.ResetFontSize,
  },
  {
    key = "2",
    mods = "ALT",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "1",
    mods = "ALT",
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = "p",
    mods = "ALT|SHIFT",
    action = wezterm.action.SpawnCommandInNewWindow {
      args = { "pwsh" },
    },
  },
  {
    key = "n",
    mods = "ALT|SHIFT",
    action = wezterm.action.SpawnCommandInNewWindow {
      args = { "nu" },
    },
  },
  {
    key = "v",
    mods = "ALT|SHIFT",
    action = wezterm.action.SpawnCommandInNewWindow {
      args = { "nu", "-c", "nvim" },
    },
  },
  {
    key = "w",
    mods = "ALT|SHIFT",
    action = wezterm.action.SpawnCommandInNewWindow {
      args = { "wsl", "--cd", "~" },
    },
  },
  {
    key = "v",
    mods = "ALT|SHIFT|CTRL",
    action = wezterm.action.SpawnCommandInNewWindow {
      args = { "wsl", "--cd", "~", "/usr/bin/nu", "-c", "with-env {NO_WINFETCH:1} {nu --login -c '__mise-hook; nvim'}" },
    },
  },
}

return config
