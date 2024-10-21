
local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Latte'
config.font = wezterm.font('JetBrains Mono')
config.font_size = 14.0

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.default_cursor_style = 'SteadyBar'

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Text = wezterm.strftime("%I:%M %d-%b-%y ")},
	}));
end);

config.leader = { key = '`' }
config.keys = {
	{ key = '`', mods = 'LEADER',       action = wezterm.action.SendKey({ key = '`' }) },

	{ key = '%', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
	{ key = '"', mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },
	{ key = 'c', mods = 'LEADER',       action = wezterm.action.SpawnTab('CurrentPaneDomain') },

	{ key = 'l', mods = 'LEADER', action = wezterm.action.ActivateLastTab },
	{ key = 's', mods = 'LEADER', action = wezterm.action.PaneSelect({ mode = 'SwapWithActive' }) },
	{ key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
	{ key = 'q', mods = 'LEADER', action = wezterm.action.PaneSelect },
	{ key = 'o', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Next' ) },
	{ key = 'h', mods = 'LEADER|ALT', action = wezterm.action.ActivatePaneDirection('Left' ) },
	{ key = 'j', mods = 'LEADER|ALT', action = wezterm.action.ActivatePaneDirection('Down' ) },
	{ key = 'k', mods = 'LEADER|ALT', action = wezterm.action.ActivatePaneDirection('Up'   ) },
	{ key = 'l', mods = 'LEADER|ALT', action = wezterm.action.ActivatePaneDirection('Right') },

	{ key = 'LeftArrow',  mods = 'LEADER', action = wezterm.action.AdjustPaneSize({'Left',  5}) },
	{ key = 'DownArrow',  mods = 'LEADER', action = wezterm.action.AdjustPaneSize({'Down',  5}) },
	{ key = 'UpArrow',    mods = 'LEADER', action = wezterm.action.AdjustPaneSize({'Up',    5}) },
	{ key = 'RightArrow', mods = 'LEADER', action = wezterm.action.AdjustPaneSize({'Right', 5}) },

	{ key = 'x', mods = 'LEADER',       action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = '&', mods = 'LEADER|SHIFT', action = wezterm.action.CloseCurrentTab({ confirm = true }) },

	{ key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
	{ key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
	{ key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
	{ key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
	{ key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
	{ key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
	{ key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
	{ key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
	{ key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },
}

return config

