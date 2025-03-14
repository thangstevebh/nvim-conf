local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

wezterm.front_end = "WebGpu"

-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window().maximize()
-- end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	if tab.is_active then
		return {
			{ Background = { Color = "#286983" } },
			{ Text = " " .. pane.pane_id .. ": " .. tab.active_pane.title .. " " },
		}
	end

	local has_unseen_output = false
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end
	if has_unseen_output then
		return {
			{ Background = { Color = "#2a283e" } },
			{ Text = " " .. pane.pane_id .. ": " .. tab.active_pane.title .. " " },
		}
	end
	return tab.active_pane.title
end)

wezterm.on("gui-attached", function(domain)
	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:gui_window():maximize()
		end
	end
end)

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	window:set_right_status(wezterm.format({
		{
			Text = wezterm.nerdfonts.fa_clock_o
				.. " "
				.. date
				.. " | "
				.. wezterm.nerdfonts.cod_workspace_trusted
				.. " "
				.. window:active_workspace()
				.. "      ",
		},
	}))
end)

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
	{ family = "Lilex Nerd Font Mono", weight = "Medium" },
	-- { family = "GeistMono Nerd Font Mono", weight = "Regular" },
	-- { family = "JetBrainsMonoNL Nerd Font", weight = "Regular" },
	{ family = "MonaspiceAr Nerd Font Propo", weight = "Regular" },
	{ family = "Noto Sans Mono CJK JP" },
	{ family = "Source Han Sans" },
	"Noto Color Emoji",
})
config.window_padding = {
	left = "1.25cell",
	right = "1.25cell",
	top = "0.75cell",
	bottom = "0.75cell",
}

config.window_decorations = "NONE"
config.cursor_thickness = "2px"

config.ssh_domains = wezterm.default_ssh_domains()
config.max_fps = 240
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400

config.color_scheme = "Gruvbox (Gogh)"
config.font_size = 13
config.font_shaper = "Harfbuzz"

config.tab_max_width = 12

config.initial_rows = 58
config.initial_cols = 210

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.6,
}

config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Regular" }),
	font_size = 13.0,
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_ime = true

config.window_background_opacity = 0.95
config.macos_window_background_blur = 90
config.text_background_opacity = 1

-- Keys binding
config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	{
		key = "v",
		mods = "SHIFT|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "h",
		mods = "SHIFT|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "f",
		mods = "SHIFT|CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	-- Switch to the default workspace
	{
		key = "y",
		mods = "CTRL|SHIFT",
		action = act.SwitchToWorkspace({
			-- name = "default",
		}),
	},
	{ key = "n", mods = "CTRL", action = act.SwitchWorkspaceRelative(1) },
	{ key = "p", mods = "CTRL", action = act.SwitchWorkspaceRelative(-1) },

	-- Create a new workspace with a random name and switch to it
	{ key = "i", mods = "CTRL|SHIFT", action = act.SwitchToWorkspace },

	{
		key = "y",
		mods = "CMD",
		action = wezterm.action.SpawnCommandInNewWindow({
			args = { "top" },
		}),
	},

	{ key = "9", mods = "SHIFT|CTRL", action = wezterm.action.ShowTabNavigator },
	{
		key = "9",
		mods = "ALT",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS" }),
	},
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
	{
		key = "Z",
		mods = "CTRL",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane
	-- mode until we cancel that mode.
	{
		key = "r",
		mods = "SHIFT|CTRL",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},

	-- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
	-- mode until we press some other key or until 1 second (1000ms)
	-- of time elapses
	{
		key = "a",
		mods = "SHIFT|CTRL",
		action = act.ActivateKeyTable({
			name = "activate_pane",
			timeout_milliseconds = 1000,
		}),
	},
}

config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},

	activate_pane = {
		{ key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
		{ key = "h", action = act.ActivatePaneDirection("Left") },

		{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },

		{ key = "UpArrow", action = act.ActivatePaneDirection("Up") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },

		{ key = "DownArrow", action = act.ActivatePaneDirection("Down") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
	},
}

-- and finally, return the configuration to wezterm
return config
