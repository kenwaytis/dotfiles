local wezterm = require 'wezterm'

local config = {}

config.color_scheme = 'Tokyo Night (Gogh)'

config.window_background_opacity = 0.8

-- 设置快捷键
config.keys = {
  { key = 't', mods = 'CTRL', action = wezterm.action_callback(function(window, pane)
    window:perform_action(wezterm.action { SpawnTab = "CurrentPaneDomain" }, pane)
  end) },
    { key = "Tab", mods = "CTRL", action = wezterm.action{ ActivateTabRelative = 1 } },
    { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action{ ActivateTabRelative = -1 } },
    { key = 'w', mods = 'CTRL', action = wezterm.action{ CloseCurrentTab = { confirm = true } } },
}

-- 启用 iem 输入法支持
config.use_ime = true

return config
