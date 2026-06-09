local colors = require("colors")

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1,
})


---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menuApps    = "rofi -show drun -matching fuzzy"
local menuWindows = "rofi -show window -matching fuzzy"
local menuWallpp  = "/home/rodrigo/.config/hypr/scripts/rofi-wallpaper-selector.sh"
local browser     = "brave"


-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/xdg-desktop-portal")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-gtk")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
    hl.exec_cmd("/usr/lib/gvfsd")
    hl.exec_cmd("/usr/lib/gvfsd-fuse")
    hl.exec_cmd("playerctld daemon")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("/usr/bin/lxqt-policykit-agent")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako -c ~/.config/mako/config")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("LIBVA_DRIVER_NAME",          "nvidia")
hl.env("GBM_BACKEND",                "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME",  "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS",    "1")
hl.env("XDG_CURRENT_DESKTOP",        "Hyprland")
hl.env("XDG_SESSION_TYPE",           "wayland")
hl.env("XDG_SESSION_DESKTOP",        "Hyprland")
hl.env("GTK_THEME",                  "adw-gtk3-dark")
hl.env("QT_QPA_PLATFORMTHEME",       "qt5ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","0")
hl.env("XCURSOR_THEME",              "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE",               "20")
hl.env("HYPRCURSOR_THEME",           "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE",            "20")
hl.env("XDG_DATA_DIRS",              "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share")
hl.env("EDITOR",                     "code")


-----------------------
----- PERMISSIONS -----
-----------------------
hl.config({
    ecosystem = {
        enforce_permissions = true,
    },
})

hl.permission("/usr/(bin|local/bin)/grim",                            "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprlock",                        "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in           = 6,
        gaps_out          = 10,
        gaps_workspaces   = 5,
        float_gaps        = 0,
        border_size       = 2,
        col = {
            active_border          = { colors = { colors.outline_variant, colors.outline }, angle = 90 },
            inactive_border        = { colors = { colors.surface_dim, colors.surface }, angle = 90 },
        --    nogroup_border_active  = colors.on_primary_fixed_variant,
        --    nogroup_border         = colors.surface_dim,
        },
        no_focus_fallback = false,
        resize_on_border  = false,
        allow_tearing     = false,
        layout            = "dwindle",
    },

    decoration = {
        rounding           = 10,
        rounding_power     = 2.0,
        active_opacity     = 0.95,
        inactive_opacity   = 0.85,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 4,
            passes   = 4,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- bezier curves
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 }    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 }    } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 }       } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 }    } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 }     } })
hl.curve("workspcSlide",   { type = "bezier", points = { { 0.1, 1 },     { 0, 1 }       } })
hl.curve("overshot",       { type = "bezier", points = { { 0.05, 0.9 },  { 0.1, 1.1 }   } })
hl.curve("wndw",           { type = "bezier", points = { { 0.05, 0.9 },  { 0.1, 1 }     } })

-- animations
hl.animation({ leaf = "global",           enabled = true,  speed = 10,  bezier = "default" })
hl.animation({ leaf = "windows",          enabled = true,  speed = 5,   bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",        enabled = true,  speed = 2.5, bezier = "wndw",         style = "popin" })
hl.animation({ leaf = "windowsOut",       enabled = true,  speed = 1.5, bezier = "linear",       style = "popin" })
hl.animation({ leaf = "layers",           enabled = true,  speed = 3.8, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "layersIn",         enabled = true,  speed = 4,   bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "layersOut",        enabled = true,  speed = 1.5, bezier = "quick",        style = "slide" })
hl.animation({ leaf = "fade",             enabled = true,  speed = 3,   bezier = "quick" })
hl.animation({ leaf = "fadeIn",           enabled = true,  speed = 1.7, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",          enabled = true,  speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true,  speed = 2,   bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true,  speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "border",           enabled = true,  speed = 10,  bezier = "easeOutQuint" })
hl.animation({ leaf = "specialWorkspace", enabled = true,  speed = 4,   bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "workspaces",       enabled = true,  speed = 5,   bezier = "workspcSlide", style = "slide" })
hl.animation({ leaf = "workspacesIn",     enabled = true,  speed = 5,   bezier = "workspcSlide", style = "slide" })
hl.animation({ leaf = "workspacesOut",    enabled = true,  speed = 5,   bezier = "workspcSlide", style = "slidefade" })
hl.animation({ leaf = "zoomFactor",       enabled = true,  speed = 7,   bezier = "quick" })

-- workspace rules
hl.workspace_rule({ workspace = "f[1]",          gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "special:extra", gaps_out = 30 })

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
})


----------------
----  MISC  ----
----------------
hl.config({
    misc = {
        force_default_wallpaper    = 0,
        disable_hyprland_logo      = true,
        font_family                = "JetbrainsMono Nerd Font",
        mouse_move_enables_dpms    = false,
        key_press_enables_dpms     = false,
        disable_autoreload         = false,
        mouse_move_focuses_monitor = true,
        background_color           = colors.background,
        initial_workspace_tracking = 1,
    },
})


---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "intl",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity  = 1,
        touchpad = {
            natural_scroll       = false,
            disable_while_typing = true,
        },
    },
    cursor = {
        inactive_timeout = 10,
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.device({
    name        = "pixa3848:00-093a:3848-touchpad",
    sensitivity = -0.1
})


---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- terminal
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(terminal))

-- browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- logout hyprland
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

-- power menu
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("wlogout"))

-- file manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + T", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + G", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + H", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- screenshot
hl.bind("Print",                   hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh -f"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh -s"))

-- menus
hl.bind(mainMod .. " + R",   hl.dsp.exec_cmd(menuApps))
hl.bind(mainMod .. " + W",   hl.dsp.exec_cmd(menuWallpp))
hl.bind(mainMod .. " + tab", hl.dsp.exec_cmd(menuWindows))
hl.bind(mainMod .. " + C",   hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- move window
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- switch/move workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- special workspace
hl.bind(mainMod .. " + A",         hl.dsp.workspace.toggle_special("extra"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "special:extra" }))

-- scroll workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- volume e brilho
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- suppress maximize events
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- fix xwayland drags
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- hyprland-run
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = { "20", "monitor_h-120" },
    float = true,
})

-- fullscreen theatre mode
hl.window_rule({
    name    = "fullscreen-theatre-mode",
    match   = { fullscreen = true },
    opacity = "1.0 override 1.0 override 1.0 override",
    no_blur = true,
})

-- floating
hl.window_rule({ match = { class = "imv" },                        float = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true })
hl.window_rule({ match = { class = "lxqt-policykit-agent" },       float = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" },       float = true })
hl.window_rule({ match = { class = "xed" },                        float = true })
hl.window_rule({ match = { class = "org.pwmt.zathura" },           float = true })
hl.window_rule({ match = { class = "Blueman-manager" },            float = true })

-- fullscreen e jogos em workspace vazia
hl.window_rule({ match = { fullscreen = true },         workspace = "empty" })
hl.window_rule({ match = { class = ".*Minecraft.*" },   workspace = "empty" })
hl.window_rule({ match = { class = "Stardew Valley" },  workspace = "empty" })