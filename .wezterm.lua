local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("FiraCode Nerd Font", { weight = "DemiBold", stretch = "Normal", style = "Normal" })
config.font_size = 12.5
config.window_background_opacity = 5.0
config.enable_tab_bar = false
-- config.window_decorations = "RESIZE"

config.color_scheme = "Catppuccin Mocha"
-- config.inactive_pane_hsb = {
-- 	saturation = 0.9,
-- 	brightness = 0.8,
-- }
return config
