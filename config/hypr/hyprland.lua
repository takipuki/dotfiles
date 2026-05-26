
hl.monitor({
	output = 'HDMI-A-1',
	mode = '1920x1080@100',
	position = '0x0',
	scale = 1,
})
hl.monitor({ -- laptop
	output = 'eDP-1',
	mode = '1920x1080',
	position = '0x0',
	scale = 1,
})

hl.on('hyprland.start', function ()
	-- hl.exec_cmd 'qbittorrent'
	hl.exec_cmd('waybar')
	hl.exec_cmd('otd-daemon')
	hl.exec_cmd('hyprpaper')
	hl.exec_cmd('pactl set-source-mute @DEFAULT_SOURCE@ 1') -- first mute mic
	hl.exec_cmd('LADSPA_PATH=/home/taki/.ladspa pipewire -c filter-chain.conf & sleep 1 && pactl set-default-source output.deepfilter')
	-- screensharing
	hl.exec_cmd('dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP')
end)

hl.env('ANV_DEBUG', 'video-decode')
hl.env('HYPRCURSOR_THEME', 'catppuccin-latte-light-cursors')
hl.env('HYPRCURSOR_SIZE', '20')
hl.env('XCURSOR_THEME', 'catppuccin-latte-light-cursors')
hl.env('XCURSOR_SIZE', '24')

hl.env("GDK_BACKEND", "wayland,x11,*")   -- GTK: Use Wayland if available; if not, try X11 and then any other GDK backend.
hl.env("QT_QPA_PLATFORM", "wayland;xcb") -- Qt: Use Wayland if available, fall back to X11 if not.
hl.env("SDL_VIDEODRIVER", "wayland")     -- Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
hl.env("CLUTTER_BACKEND", "wayland")

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
	input = {
		kb_layout = 'us,bd',
		kb_options = 'grp:win_space_toggle,caps:super,ctrl:ralt_rctrl',

		repeat_rate = 40,
		repeat_delay = 200,

		follow_mouse = 2,
		float_switch_override_focus = 0,
		scroll_factor = 0.5,

		touchpad = {
			natural_scroll = true,
			middle_button_emulation = true,
		},

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		tablet = {
			output = 'DP-1',
		},
	},
	general = {
		gaps_in = 4,
		gaps_out = 12,
		border_size = 2,
		resize_on_border = true,
		col = {
			active_border = '#b4befeff',
			inactive_border = '#595959aa',
		},

		layout = dwindle,
	},
	decoration = {
		rounding = 10,

		blur = {
			enabled = false,
			size = 3,
			passes = 1,
		},

		dim_inactive = false,
		dim_strength = 0.1,
		dim_special = 0.3,

		shadow = {
			enabled = false,
		},
	},
	group = {
		auto_group = false,
		col = { border_active = '#4c4f69FF' },
		groupbar = {
			height = 1,
			font_size = 10,
			render_titles = false,
			text_color = '#eff1f5',
			col = { active = '#4c4f69FF', inactive = '#4c4f6900' },
			rounding = 10,
			keep_upper_gap = false,
		}
	},
	dwindle = {
		preserve_split = true, -- you probably want this
		split_width_multiplier = 1.25,
	},
	master = {
		mfact = 0.6,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		animate_manual_resizes = true,
	},
	binds = {
		allow_workspace_cycles = true,
		movefocus_cycles_fullscreen = 1,
	},
})

hl.curve('myBezier', { type = 'bezier', points = { {.05, .9}, {.1, 1.05} } })
hl.animation({
	leaf = 'windows',
	enabled = true,
	speed = 7,
	bezier = 'myBezier',
	style = 'slide',
})
hl.animation({ leaf = 'border', enabled = true, speed = 10, bezier = 'myBezier' })
hl.animation({ leaf = 'borderangle', enabled = true, speed = 8, bezier = 'myBezier' })
hl.animation({ leaf = 'workspaces', enabled = false })
hl.animation({ leaf = 'fade', enabled = false })

hl.window_rule({
	name = 'float_and_resize',
	match = {
		float = false,
		class = '.*(yad|zenity|firefox|pavucontrol|qBittorrent|mpv|xdg-desktop-portal).*',
	},
	float = true,
	center = true,
	size = {'(monitor_w*0.7)', '(monitor_h*0.7)'},
})

hl.window_rule({
	name = float,
	match = {
		float = false,
		class = '.*(feh|steam_app_default|PacketTracer).*',
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = 'fullscreen-border-color',
	match = { fullscreen = true, },
	border_color = '#F38BA8FF',
})

function bind(keys, cmd, flags)
	if type(cmd) == 'string' then
		hl.bind(keys, hl.dsp.exec_cmd(cmd), flags)
	else
		hl.bind(keys, cmd, flags)
	end
end

-- bind('CTRL+V', 'bash ~/s.sh', { non_consuming = true })
bind('SUPER+T', 'kitty')
bind('SUPER+N', 'neovide')
bind('SUPER+E', 'thunar')
bind('SUPER+R', '$(tofi-run)')

hl.layer_rule({
	match = { class = 'selector', },
	no_anim = true,
})
bind('      Print', 'hyprshot -sz -m region --clipboard-only')
bind('SHIFT+Print', 'hyprshot -m window -m active --clipboard-only')

bind('SUPER+CTRL+Z', 'zenity --text-info --editable')
bind('SUPER+CTRL+I', 'wl-paste -t image | feh -.Z -')
bind('SUPER+CTRL+W', 'wl-paste -t image | magick - -fuzz 5% -fill none -opaque white -fill "##4c4f69" -opaque black - | wl-copy')
bind('SUPER+CTRL+Q', 'wl-paste | qrencode -o - | feh -.Z -')
bind('SUPER+CTRL+C', 'hyprpicker | wl-copy')
bind('SUPER+CTRL+L', 'wl-paste | tr -d "\n" | /home/taki/.local/scripts/latex2unicode.js | wl-copy')

function audio_sink_switch()
	local p = io.popen('pactl list sinks')
	if p:read('a'):find('Active Port: analog%-output%-headphones') then
		hl.exec_cmd('pactl set-sink-port @DEFAULT_SINK@ analog-output-lineout')
	else
		hl.exec_cmd('pactl set-sink-port @DEFAULT_SINK@ analog-output-headphones')
	end
	p:close()
end
function audio_source_mute_set(state)
	local cmd = 'pactl set-source-mute 55 %d & pactl set-source-mute @DEFAULT_SOURCE@ %d'
	return function () hl.exec_cmd(cmd:format(state, state)) end
end
function mpc(args)
	local cmd = 'mpc --host=/home/taki/.local/share/mpd/socket %s'
	return function () hl.exec_cmd(cmd:format(args)) end
end
bind('SUPER+XF86AudioRaiseVolume', mpc('volume +5'))
bind('SUPER+XF86AudioLowerVolume', mpc('volume -5'))
bind('      XF86AudioPlay',        mpc('toggle'))
bind('      XF86AudioStop',        mpc('stop'))
bind('      XF86AudioPrev',        mpc('prev'))
bind('      XF86AudioNext',        mpc('next'))
bind('      XF86AudioRaiseVolume', 'pactl set-sink-volume @DEFAULT_SINK@ +5%')
bind('      XF86AudioLowerVolume', 'pactl set-sink-volume @DEFAULT_SINK@ -5%')
bind('      XF86AudioMute',        audio_sink_switch)
bind('      Home',                 audio_source_mute_set(0))
bind('      Home',                 audio_source_mute_set(1), { release = true })

bind('SUPER+Q',               hl.dsp.window.close())
bind('SUPER+SHIFT+Q',         hl.dsp.exec_raw('hyprctl kill'))
bind('SUPER+SHIFT+Backspace', hl.dsp.exit())

bind('SUPER+TAB',     hl.dsp.window.float())
bind('SUPER+F',       hl.dsp.window.fullscreen({ mode = 'maximized' } ))
bind('SUPER+SHIFT+F', hl.dsp.window.fullscreen({ mode = 'fullscreen' }))

-- Switch to a submap called `resize`.
hl.bind('SUPER+SHIFT+R', hl.dsp.submap('resize'))
-- Start a submap called 'resize'.
hl.define_submap('resize', function()
	-- Set repeating binds for resizing the active window.
	hl.bind('l', hl.dsp.window.resize({ x =  15, y =   0, relative = true }), { repeating = true })
	hl.bind('h', hl.dsp.window.resize({ x = -15, y =   0, relative = true }), { repeating = true })
	hl.bind('k', hl.dsp.window.resize({ x =   0, y = -15, relative = true }), { repeating = true })
	hl.bind('j', hl.dsp.window.resize({ x =   0, y =  15, relative = true }), { repeating = true })

	-- Use `reset` to go back to the global submap
	hl.bind('catchall', hl.dsp.submap('reset'))
end)

-- dwindle
bind('SUPER+S', hl.dsp.layout('togglesplit'))

-- Move focus with SUPER + vim keys
bind('SUPER+H', hl.dsp.focus({ direction = 'l' }))
bind('SUPER+L', hl.dsp.focus({ direction = 'r' }))
bind('SUPER+K', hl.dsp.focus({ direction = 'u' }))
bind('SUPER+J', hl.dsp.focus({ direction = 'd' }))
bind('SUPER+P', hl.dsp.window.pin())
bind('SUPER+O', hl.dsp.focus({ window = 'floating' }))
bind('SUPER+I', hl.dsp.focus({ window = 'tiled' }))
bind('ALT+TAB', hl.dsp.focus({ workspace = 'previous' }))

-- Move position of windows
bind('SUPER+SHIFT+H', hl.dsp.window.move({ direction = 'l' }))
bind('SUPER+SHIFT+L', hl.dsp.window.move({ direction = 'r' }))
bind('SUPER+SHIFT+K', hl.dsp.window.move({ direction = 'u' }))
bind('SUPER+SHIFT+J', hl.dsp.window.move({ direction = 'd' }))
bind('SUPER+C', hl.dsp.window.center())
bind('SUPER+A', function ()
	hl.dispatch(hl.dsp.window.float({ action = 'on' }))
	local m = hl.get_active_monitor()
	hl.dispatch(hl.dsp.window.resize({ x = m.width*.7, y = m.height*.7, relative = false }))
	hl.dispatch(hl.dsp.window.center())
end)

-- group
bind('SUPER+G',      hl.dsp.group.toggle())
bind('SUPER+ALT+H',  hl.dsp.window.move({ direction = 'l', group_aware = true }))
bind('SUPER+ALT+L',  hl.dsp.window.move({ direction = 'r', group_aware = true }))
bind('SUPER+ALT+K',  hl.dsp.window.move({ direction = 'u', group_aware = true }))
bind('SUPER+ALT+J',  hl.dsp.window.move({ direction = 'd', group_aware = true }))
bind('SUPER+PERIOD', hl.dsp.group.next())
bind('SUPER+COMMA',  hl.dsp.group.prev())
bind('SUPER+mouse:276', hl.dsp.group.next())
bind('SUPER+mouse:275', hl.dsp.group.prev())
bind('SUPER+SHIFT+PERIOD', hl.dsp.group.move_window({ forward = true }))
bind('SUPER+SHIFT+COMMA',  hl.dsp.group.move_window({ forward = false }))

-- workspace
bind('SUPER+1', hl.dsp.focus({ workspace = 1 }))
bind('SUPER+2', hl.dsp.focus({ workspace = 2 }))
bind('SUPER+3', hl.dsp.focus({ workspace = 3 }))
bind('SUPER+4', hl.dsp.focus({ workspace = 4 }))
bind('SUPER+5', hl.dsp.focus({ workspace = 5 }))
bind('SUPER+6', hl.dsp.focus({ workspace = 6 }))
bind('SUPER+7', hl.dsp.focus({ workspace = 7 }))
bind('SUPER+8', hl.dsp.focus({ workspace = 8 }))
bind('SUPER+9', hl.dsp.focus({ workspace = '-1' }))
bind('SUPER+0', hl.dsp.focus({ workspace = '+1' }))

bind('SUPER+SHIFT+1', hl.dsp.window.move({ workspace = 1, follow = false }))
bind('SUPER+SHIFT+2', hl.dsp.window.move({ workspace = 2, follow = false }))
bind('SUPER+SHIFT+3', hl.dsp.window.move({ workspace = 3, follow = false }))
bind('SUPER+SHIFT+4', hl.dsp.window.move({ workspace = 4, follow = false }))
bind('SUPER+SHIFT+5', hl.dsp.window.move({ workspace = 5, follow = false }))
bind('SUPER+SHIFT+6', hl.dsp.window.move({ workspace = 6, follow = false }))
bind('SUPER+SHIFT+7', hl.dsp.window.move({ workspace = 7, follow = false }))
bind('SUPER+SHIFT+8', hl.dsp.window.move({ workspace = 8, follow = false }))
bind('SUPER+SHIFT+9', hl.dsp.window.move({ workspace = '-1', follow = false }))
bind('SUPER+SHIFT+0', hl.dsp.window.move({ workspace = '+1', follow = false }))

bind('SUPER+mouse:272', hl.dsp.window.drag(), { mouse = true })
bind('SUPER+mouse:273', hl.dsp.window.resize(), { mouse = true })

-- scratchpad
function window_minimize_toggle()
	local ws = hl.get_active_special_workspace()
	if ws then
		hl.dispatch(hl.dsp.window.move({
			workspace = '+0',
			follow = true
		}))
	else
		hl.dispatch(hl.dsp.window.move({
			workspace = 'special:special',
			follow = false
		}))
	end
end
bind('SUPER+code:20', window_minimize_toggle)
bind('SUPER+code:21', hl.dsp.workspace.toggle_special())
bind('SUPER+grave', hl.dsp.workspace.toggle_special())
