-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Modus-Operandi'
config.font = wezterm.font 'Iosevka'
config.font_size = 18
config.enable_tab_bar = false
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.window_padding = {
  left = '0',
  right = '0',
  top = '0',
  bottom = '0',
}

-- and finally, return the configuration to wezterm
return config
