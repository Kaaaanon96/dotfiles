local wezterm = require("wezterm")
local config = wezterm.config_builder()

local home_dir =  wezterm.home_dir
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local LIST_ORDER = wezterm.nerdfonts.cod_list_ordered
local SPLIT_ICON = wezterm.nerdfonts.cod_chevron_right
local RIGHT_ARROW = wezterm.nerdfonts.oct_triangle_right
local WORKSPACE_ICON = wezterm.nerdfonts.md_folder_open_outline
local EDIT_ICON = wezterm.nerdfonts.md_folder_edit_outline

--------------------------
-- hot reload
--------------------------
config.automatically_reload_config = true

--------------------------
-- base
--------------------------
config.scrollback_lines = 3500

--------------------------
-- color scheme
--------------------------
config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Dracula"
-- config.color_scheme = "Dracula (base16)"
-- config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Dracula (Gogh)"
-- config.color_scheme = "Dracula+"

--------------------------
-- window/tab/pane design
--------------------------
config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.1,
}

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 50

local schemes = wezterm.color.get_builtin_schemes()
local scheme = schemes['Catppuccin Latte']
config.colors = { tab_bar = scheme.tab_bar }
config.colors.tab_bar.active_tab.intensity = "Bold"
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local index = tab.tab_index + 1
  local truncate_limit = math.max(1, max_width - 10)
  local truncate_title = wezterm.truncate_right(tab.active_pane.title, truncate_limit)
  local full_title = " " .. index .. ": " .. truncate_title .. " "

  local bg
  local fg
  if tab.is_active then
    bg = scheme.tab_bar.active_tab.bg_color
    fg = scheme.tab_bar.active_tab.fg_color
  elseif hover then
    bg = scheme.tab_bar.inactive_tab_hover.bg_color
    fg = scheme.tab_bar.inactive_tab_hover.fg_color
  else
    bg = scheme.tab_bar.inactive_tab.bg_color
    fg = scheme.tab_bar.inactive_tab.fg_color
  end
  local edge_background = scheme.tab_bar.background

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = bg } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = full_title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = bg } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

--------------------------
-- bg
--------------------------
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

--------------------------
-- font
--------------------------
config.font = wezterm.font("UDEV Gothic 35JPDOC")
-- config.font = wezterm.font_with_fallback {
--   { family = "UDEV Gothic 35JPDOC" },
--   { family = "UDEV Gothic 35NF" },
-- }
config.font_size = 12.0
config.freetype_load_target = "Light"
config.front_end = "WebGpu"

config.use_ime = true

--------------------------
-- mapping
--------------------------
config.disable_default_key_bindings = true

config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

local act = wezterm.action
config.keys = {
  -- copy/paste
  { key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
  { key = "v", mods ="LEADER", action = act.ActivateCopyMode, },
  -- search && scroll
  {
    key = "f",
    mods = "CMD",
    action = act.Search("CurrentSelectionOrEmptyString"),
  },
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
  { key = "w", mods = "LEADER", action = act.CloseCurrentPane { confirm = true }, },
  -- workspace
  {
    key = "s",
    mods = "LEADER",
    -- action = act.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select workspace" }) 
    action = wezterm.action_callback(function(win, pane)
      local workspaces = {}
      for i, name in ipairs(wezterm.mux.get_workspace_names()) do
        table.insert(workspaces, {
          id = name,
          label = string.format("%d. %s", i, name)
        })
        local current = wezterm.mux.get_active_workspace()
        win:perform_action(act.InputSelector({
          action = wezterm.action_callback(function(_, _, id, label)
            if not id and not label then
              wezterm.log_info("Workspace selection canceled")
            else
              win:perform_action(act.SwitchToWorkspace({ name = id }), pane)
            end
          end),
          title = "Select workspace",
          choices = workspaces,
          fuzzy = true,
          fuzzy_description = string.format(" [wezterm] %s Select Workspace%s Current: %s%s Next: ", LIST_ORDER, SPLIT_ICON, current, RIGHT_ARROW),
        }), pane)
      end
    end)
  },
  {
    key = "S",
    mods = "LEADER|SHIFT",
    action = act.PromptInputLine({
      description = string.format(" [wezterm] %s Create Workspace%s Enter Name:", WORKSPACE_ICON, SPLIT_ICON),
      action = wezterm.action_callback(function(win, pane, line)
        if line then
          win:perform_action(act.SwitchToWorkspace({ name = line }), pane)
        end
      end),
    })
  },
  {
    key = "r",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = string.format(" [wezterm] %s Rename Workspace%s Enter New Name: ", EDIT_ICON, SPLIT_ICON),
      action = wezterm.action_callback(function(win, pane, line)
        if line then
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    })
  },
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
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = act.OpenLinkAtMouseCursor,
  },
}
config.key_tables = {
  search_mode = {
    { key = "Enter", mods = "NONE", action = act.CopyMode("NextMatch") },
    { key = "Enter", mods = "SHIFT",  action = act.CopyMode("PriorMatch") },
  }
}

return config
