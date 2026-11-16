--  _                       
-- | |__   ___  _ __  _   _ 
-- | '_ \ / _ \| '_ \| | | |
-- | | | | (_) | |_) | |_| |
-- |_| |_|\___/| .__/ \__,_|
--            |_|           
--
-- Hyprland Lua config (the hyprlang hyprland.conf format is legacy since 0.55).
-- API reference for editor completion: /usr/share/hypr/stubs/hl.meta.lua
-- Validate before restarting: Hyprland --verify-config -c ~/.config/hypr/hyprland.lua

local HOME = os.getenv("HOME")

----------------
--- MONITORS ---
----------------

-- Laptop panel: explicit by name (its EDID carries no description on Asahi).
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = "1.2" })
-- Anything unknown (projectors, hotel TVs): native scale.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })
hl.monitor({ output = "desc:Dell Inc. DELL U3023E 3FXJ4H3", mode = "2560x1600@59.97", position = "auto", scale = "1" })
hl.monitor({ output = "desc:Dell Inc. DELL U3824DW G9NLZR3", mode = "3840x1600@60.00", position = "auto", scale = "1" })

-------------------
--- MY PROGRAMS ---
-------------------

local apps = {
  terminal    = "foot",
  fileManager = "dolphin",
  menu        = "rofi -show drun",
  windows     = "rofi -show window",
  bluetooth   = "systemsettings kcm_bluetooth",
  browser     = "brave-browser",
}

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

-- fix no apps in context menu in QT apps
hl.env("XDG_MENU_PREFIX", "kde-")

-- cursor theme preloading
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Simp1e-Gruvbox-Dark")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Simp1e-Gruvbox-Dark")

hl.env("QT_QPA_PLATFORMTHEME", "kde")

-- Electron apps (Positron, Spotify, ...) pick native Wayland instead of a blurry scaled XWayland window.
-- VS Code >= 1.14x does this on its own; older Electron builds need the hint.
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Intel/NVIDIA laptop only (main branch). Not valid on Apple Silicon: card numbers are
-- not stable and aquamarine auto-detects the display controller.
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card2:/dev/dri/card1")
-- hl.env("LIBVA_DRIVER_NAME", "iHD")

-----------------
--- AUTOSTART ---
-----------------

-- Runs once at compositor start (the equivalent of exec-once).
hl.on("hyprland.start", function()
  -- main stuff
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("while true; do waybar -l warning; sleep 2; done")

  -- external monitor handling https://gitlab.freedesktop.org/emersion/kanshi
  hl.exec_cmd("kanshi")
  hl.exec_cmd("udiskie -ant")

  -- polkit agent (same unit name on Fedora and Arch)
  hl.exec_cmd("systemctl --user start plasma-polkit-agent.service")

  -- network indicator in tray
  hl.exec_cmd("nm-applet --indicator")

  -- Dropbox (the maestral_qt entry point is broken in maestral-qt 1.9.8)
  hl.exec_cmd("maestral gui")
  hl.exec_cmd("kbuildsycoca6 --noincremental")

  -- hyprpm: loads hy3; Hyprland reloads this config once the plugin is in
  hl.exec_cmd("hyprpm reload -n")

  hl.exec_cmd("wl-paste --watch cliphist store")
  hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"') -- for GTK4 apps
end)

---------------------
--- LOOK AND FEEL ---
---------------------

hl.config({
  general = {
    gaps_in     = 5,
    gaps_out    = 10,
    border_size = 2,

    col = {
      active_border   = "rgb(689d6a)",
      inactive_border = "rgb(595959)",
    },

    resize_on_border = false,
    allow_tearing    = false,

    -- i3-like layout from the hy3 plugin
    layout = "hy3",
  },

  decoration = {
    active_opacity   = 1.0,
    inactive_opacity = 0.80,
    rounding         = 4,

    blur = {
      enabled  = true,
      size     = 10,
      passes   = 2,
      vibrancy = 0.1696,
    },
  },

  animations = { enabled = true },

  dwindle = {
    preserve_split = true,
  },

  misc = {
    force_default_wallpaper    = 0,
    disable_hyprland_logo      = true,
    vrr                        = 2,
    allow_session_lock_restore = true,
  },

  render = { direct_scanout = 0 },

  cursor = { sync_gsettings_theme = false },

  input = {
    kb_layout  = "us,ru",
    kb_options = "grp:alt_space_toggle",

    follow_mouse  = 1,
    mouse_refocus = false,
    sensitivity   = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll       = true,
      clickfinger_behavior = true,
      tap_to_click         = false,
    },
  },

  debug = {
    disable_logs       = false,
    enable_stdout_logs = true,
  },
})

-- Animations
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",    enabled = true,  speed = 5,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true,  speed = 5,  bezier = "myBezier", style = "popin 50%" })
hl.animation({ leaf = "border",     enabled = true,  speed = 10, bezier = "myBezier" })
hl.animation({ leaf = "fade",       enabled = true,  speed = 5,  bezier = "myBezier" })
hl.animation({ leaf = "workspaces", enabled = false })

-- 3-finger horizontal swipe switches workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-----------
--- hy3 ---
-----------
-- i3 plugin for hyprland https://github.com/outfoxxed/hy3
-- hy3 is loaded by hyprpm after this file first runs; its options and Lua dispatchers
-- (hl.plugin.hy3) only exist once it is in, so everything hy3-specific is guarded and
-- registers on the reload Hyprland triggers after the plugin loads.
-- Colours are ARGB integers: rgb(RRGGBB) -> 0xffRRGGBB, rgba(RRGGBBAA) -> 0xAARRGGBB.
-- Option names: strings /var/cache/hyprpm/$USER/hy3/hy3.so | grep -o 'plugin:hy3:[A-Za-z0-9_.:]*'

local hy3 = hl.plugin.hy3

if hy3 then
  hl.config({
    plugin = {
      hy3 = {
        -- 0 always show gaps, 1 hide gaps with a single window, 2 = 1 but show the border
        no_gaps_when_only = 0,
        -- 0 remove nested group, 1 keep it, 2 keep it only if its parent is a tab group
        node_collapse_policy = 2,
        -- offset from group split direction when only one window is in a group
        group_inset = 10,
        -- auto-create a tab group for the first window on a workspace
        tab_first_window = false,

        tabs = {
          height       = 30,
          padding      = 4,
          radius       = 4,
          border_width = 2,
          render_text  = true,
          text_center  = true,
          text_font    = "JetBrainsMono Nerd Font Bold",
          text_height  = 15,
          text_padding = 0,

          -- (older hy3 used col.active / col.active.border; those names no longer exist)
          colors = {
            active        = 0xff689d6a, -- rgb(689d6a)
            active_border = 0x99689d6a, -- rgba(689d6a99)
            active_text   = 0xff282828, -- rgb(282828)

            -- focused node in an unfocused container
            focused        = 0xff3c3836, -- rgba(3c3836ff)
            focused_border = 0x993c3836, -- rgba(3c383699)
            focused_text   = 0xffebdbb2, -- rgb(ebdbb2)

            inactive        = 0x993c3836, -- rgba(3c383699)
            inactive_border = 0x55665c54, -- rgba(665c5455)
            inactive_text   = 0xffebdbb2, -- rgb(ebdbb2)

            urgent        = 0xfffb4934, -- rgba(fb4934ff)
            urgent_border = 0x99fb4934, -- rgba(fb493499)
            urgent_text   = 0xff282828, -- rgb(282828)
          },

          -- blur is only visible when the colours above are not opaque
          blur    = true,
          opacity = 1,
        },

        autotile = {
          enable           = false,
          ephemeral_groups = false,
          trigger_width    = 0, -- 0 always split vertically, -1 never, N pixel width
          trigger_height   = 0,
          workspaces       = "all",
        },
      },
    },
  })
end

-------------------
--- KEYBINDINGS ---
-------------------

require("conf.keybindings")(apps, hy3)

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

hl.workspace_rule({ workspace = "1", default = true })

-- float rules
hl.window_rule({ match = { class = "^(yad)$" },            float = true })
hl.window_rule({ match = { class = "^(waypaper)$" },       float = true })
hl.window_rule({ match = { class = "^(pavucontrol-qt)$" }, float = true })

-- opacity rules (two values = active inactive)
hl.window_rule({ match = { class = "^(Spotify)$" },        opacity = "0.90 0.90" })
hl.window_rule({ match = { class = "^(Cider)$" },          opacity = "0.90 0.90" })
hl.window_rule({ match = { class = "^(Code|com\\.microsoft\\.VSCode)$" }, opacity = "0.90 0.90" }) -- VS Code >= 1.9x on Wayland uses the reverse-DNS app id
hl.window_rule({ match = { class = "^(Positron|positron)$" }, opacity = "0.90 0.90" })           -- "Positron" under XWayland, "positron" on native Wayland
hl.window_rule({ match = { class = "^(webcatalog-custom-1698710090367)$" }, opacity = "0.90 0.90" }) -- "messengers" app built with WebCatalog; its app id is its desktop file name, not the app name
hl.window_rule({ match = { class = "^(rstudio)$" },        opacity = "0.90 0.90" })
hl.window_rule({ match = { class = "^(dev\\.warp\\.Warp)$" }, opacity = "0.85 0.85" })
hl.window_rule({ match = { class = "^(foot)$" },           opacity = "0.85 0.85" })

-- other
hl.window_rule({
  -- fix some dragging issues with XWayland
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})
hl.window_rule({ match = { class = "^(yad)$" }, size = "600 300" })
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({ match = { class = "^(Zoom Workplace)$" }, float = true })
hl.window_rule({ match = { class = "^(Zoom Workplace)$", title = "^()$" }, stay_focused = true })
hl.window_rule({ match = { class = "^(Zoom Workplace)$", title = "^()$" }, min_size = "1 1" })

-- layer rules
hl.layer_rule({ match = { namespace = "waybar" },        blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })
