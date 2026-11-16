-- Keybindings. Loaded from hyprland.lua as require("conf.keybindings")(apps, hy3).
-- Every bind carries a desc; scripts/keybindings.sh reads them back via `hyprctl binds -j`
-- to build the Super+K cheat sheet.

return function(apps, hy3)
  local mod = "SUPER" -- "Windows" key as main modifier

  -- keys: "SUPER + SHIFT + Q" style; dispatcher: hl.dsp.* factory; desc: shown in the cheat sheet
  local function bind(keys, dispatcher, desc, opts)
    opts = opts or {}
    opts.desc = desc
    return hl.bind(keys, dispatcher, opts)
  end

  local function exec(cmd) return hl.dsp.exec_cmd(cmd) end

  bind(mod .. " + Return",    exec(apps.terminal),                                   "Open the terminal")
  bind(mod .. " + SHIFT + Q", hl.dsp.window.close(),                                 "Close the active window")
  bind(mod .. " + D",         exec(apps.fileManager),                                "Open the file manager")
  bind(mod .. " + V",         hl.dsp.window.float({ action = "toggle" }),            "Toggle floating mode for the active window")
  bind(mod .. " + Space",     exec(apps.menu),                                       "Launch the application menu")
  bind(mod .. " + Tab",       exec(apps.windows),                                    "Switch between open windows")
  bind(mod .. " + F",         hl.dsp.window.fullscreen(),                            "Toggle fullscreen for the active window")
  bind(mod .. " + SHIFT + E", exec("wlogout -b 5"),                                  "Show logout menu")
  bind(mod .. " + B",         exec(apps.bluetooth),                                  "Open Bluetooth manager")
  bind(mod .. " + K",         exec(os.getenv("HOME") .. "/.config/hypr/scripts/keybindings.sh"), "Open keybindings menu")
  bind(mod .. " + T",         hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }), "Toggle opaqueness for the window")

  -- hy3 groups and directional focus/move (only once the plugin is loaded)
  if hy3 then
    bind(mod .. " + E", hy3.change_group("toggletab"),                        "Toggle tabbed group for active window")
    bind(mod .. " + W", hy3.make_group("v", { toggle = true, ephemeral = true }), "Create/toggle a vertical group")

    -- Move focus with mainMod + arrows
    bind(mod .. " + left",  hy3.move_focus("l", { warp = false }), "Focus left window")
    bind(mod .. " + right", hy3.move_focus("r", { warp = false }), "Focus right window")
    bind(mod .. " + up",    hy3.move_focus("u", { warp = false }), "Focus window above")
    bind(mod .. " + down",  hy3.move_focus("d", { warp = false }), "Focus window below")

    -- Move window with mainMod + SHIFT + arrows
    bind(mod .. " + SHIFT + left",  hy3.move_window("l", { once = true }), "Move window left")
    bind(mod .. " + SHIFT + right", hy3.move_window("r", { once = true }), "Move window right")
    bind(mod .. " + SHIFT + up",    hy3.move_window("u", { once = true }), "Move window up")
    bind(mod .. " + SHIFT + down",  hy3.move_window("d", { once = true }), "Move window down")
  end

  -- Switch workspaces with mainMod + [0-9]; move window with mainMod + SHIFT + [0-9]
  for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    bind(mod .. " + " .. key,            hl.dsp.focus({ workspace = i }),       "Switch to workspace " .. i)
    bind(mod .. " + SHIFT + " .. key,    hl.dsp.window.move({ workspace = i }), "Move window to workspace " .. i)
  end

  -- Screenshots (hyprshot)
  bind(mod .. " + CTRL + SHIFT + S", exec("hyprshot -m region"), "Screenshot a region")
  bind(mod .. " + SHIFT + S",        exec("hyprshot -m window"), "Screenshot a window")

  -- Move/resize windows with mainMod + LMB/RMB and dragging
  bind(mod .. " + mouse:272", hl.dsp.window.drag(),   "Move window with left mouse button")
  bind(mod .. " + mouse:273", hl.dsp.window.resize(), "Resize window with right mouse button")

  -- Laptop multimedia keys for volume and LCD brightness (work while locked, repeat when held)
  local media = { locked = true, repeating = true }
  bind("XF86AudioRaiseVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),     "Volume up",          media)
  bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),     "Volume down",        media)
  bind("XF86AudioMute",        exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),    "Toggle audio mute",  media)
  bind("XF86AudioMicMute",     exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),  "Toggle mic mute",    media)
  bind("XF86MonBrightnessUp",  exec("brightnessctl s 10%+"),                          "Increase brightness", media)
  bind("XF86MonBrightnessDown",exec("brightnessctl s 10%-"),                          "Decrease brightness", media)

  -- Requires playerctl (disabled)
  -- bind("XF86AudioNext",  exec("playerctl next"),       "Next media track",     { locked = true })
  -- bind("XF86AudioPause", exec("playerctl play-pause"), "Play/pause media",     { locked = true })
  -- bind("XF86AudioPlay",  exec("playerctl play-pause"), "Play/pause media",     { locked = true })
  -- bind("XF86AudioPrev",  exec("playerctl previous"),   "Previous media track", { locked = true })
end
