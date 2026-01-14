local wezterm = require("wezterm")
local config = wezterm.config_builder()

local home_dir =  wezterm.home_dir

-- hot reload
config.automatically_reload_config = true

-- color scheme
config.color_scheme = 'Dracula (Official)'

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


-- key map
config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {
  { key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
  { key = "d", mods = "CMD", action = act.SplitHorizontal({}) },
  { key = "d", mods = "SHIFT|CMD", action = act.SplitVertical({}) },
  { key = "t", mods = "CMD", action = act.SpawnCommandInNewTab({ cwd = home_dir }) },
  { key = "t", mods = "SHIFT|CMD", action = act.SpawnTab("CurrentPaneDomain") },
}

return config
