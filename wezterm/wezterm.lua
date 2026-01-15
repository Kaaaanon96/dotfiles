local wezterm = require("wezterm")
local config = wezterm.config_builder()

local home_dir =  wezterm.home_dir

-- hot reload
config.automatically_reload_config = true

config.scrollback_lines = 3500

-- color scheme
-- config.color_scheme = "Dracula"
-- config.color_scheme = "Dracula (base16)"
-- config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Dracula (Gogh)"
-- config.color_scheme = "Dracula+"
config.color_scheme = "Dracula (Official)"

-- bg
local bg_image_path = home_dir .. "/dotfiles/bg_img/092.jpg"
config.background = {
  {
    source = { File = bg_image_path },
    width = "100%",
    height = "100%",
    repeat_x = "NoRepeat",
    repeat_y = "NoRepeat",
    vertical_align = "Middle",
    horizontal_align = "Center",
    opacity = 0.75,
    hsb = { brightness = 0.5, saturation = 0.9 }
  },
  {
    source = { Color = "#1e1e2e" },
    width = "100%",
    height = "100%",
    opacity = 0.85,
  }
}
config.macos_window_background_blur = 10

-- font
config.font = wezterm.font("UDEV Gothic 35JPDOC")
-- config.font = wezterm.font_with_fallback {
--   { family = "UDEV Gothic 35JPDOC" },
--   { family = "UDEV Gothic 35NF" },
-- }
config.font_size = 12.0
config.freetype_load_target = "Light"
config.front_end = "WebGpu"

-- window/tab/pane design
config.show_new_tab_button_in_tab_bar = false

config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.1,
}

-- mapping
config.disable_default_key_bindings = true

config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

local act = wezterm.action
config.keys = {
  -- copy/paste
  { key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
  -- search && scroll
  { key = "f", mods = "CMD", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "k", mods = "CMD", action = act.ClearScrollback("ScrollbackOnly") },
  -- pane
  { key = "d", mods = "CMD", action = act.SplitHorizontal({}) },
  { key = "d", mods = "SHIFT|CMD", action = act.SplitVertical({}) },
  { key = "h", mods ="LEADER", action = act.ActivatePaneDirection("Left"), },
  { key = "l", mods ="LEADER", action = act.ActivatePaneDirection("Right"), },
  { key = "k", mods ="LEADER", action = act.ActivatePaneDirection("Up"), },
  { key = "j", mods ="LEADER", action = act.ActivatePaneDirection("Down"), },
  -- tab
  { key = "t", mods = "CMD", action = act.SpawnCommandInNewTab({ cwd = home_dir }) },
  { key = "t", mods = "SHIFT|CMD", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
  { key = "w", mods = "LEADER", action = wezterm.action.CloseCurrentPane { confirm = true }, },
  -- utils
  { key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
}

-- mapping: tab select(1~9)
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CMD",
    action = act.ActivateTab(i - 1),
  })
end

return config
