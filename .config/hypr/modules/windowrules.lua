---------------------
---- WINDOWRULES ----
---------------------

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

-- kitty on float bind
hl.window_rule({
  name = "float-terminal",
  match = { class = "kitty-float" },
  float = true,
})

-- floating
hl.window_rule({ match = { class = "imv" },                        float = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true })
hl.window_rule({ match = { class = "lxqt-policykit-agent" },       float = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" },       float = true })
hl.window_rule({ match = { class = "xed" },                        float = true })
hl.window_rule({ match = { class = "org.pwmt.zathura" },           float = true })
hl.window_rule({ match = { class = "blueman-manager" },            float = true })

-- fullscreen e jogos em workspace vazia
hl.window_rule({ match = { fullscreen = true },         workspace = "empty" })
hl.window_rule({ match = { class = ".*Minecraft.*" },   workspace = "empty" })
hl.window_rule({ match = { class = "Stardew Valley" },  workspace = "empty" })