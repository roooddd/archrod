-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in           = 4,
        gaps_out          = 12,
        gaps_workspaces   = 5,
        float_gaps        = 0,
        border_size       = 1,
        col = {
            active_border          = { colors = { colors.primary, colors.primary_fixed }, angle = 90 },
            inactive_border        = { colors = { colors.outline, colors.outline_variant }, angle = 90 },
        --    nogroup_border_active  = colors.on_primary_fixed_variant,
        --    nogroup_border         = colors.surface_dim,
        },
        no_focus_fallback = false,
        resize_on_border  = false,
        allow_tearing     = false,
        layout            = "dwindle",
    },

    decoration = {
        rounding           = 5,
        rounding_power     = 2.0,
        active_opacity     = 0.95,
        inactive_opacity   = 0.80,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 4,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled    = true,

            brightness = 0.6, -- can be changed in future light mode
            contrast   = 1,
            noise      = 0,
            size       = 2,
            passes     = 4,
            
            special    = false,
        },

        glow = {
            enabled = false,
        },

        motion_blur = {
            enabled = false,
            samples = 64,
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
hl.animation({ leaf = "windowsIn",        enabled = true,  speed = 2.5, bezier = "wndw",         style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true,  speed = 1.5, bezier = "linear",       style = "slide" })
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
        preserve_split               = true,
        force_split                  = 0,
        smart_split                  = false,
        smart_resizing               = true,
        permanent_direction_override = false,
        special_scale_factor         = 1,
        split_width_multiplier       = 1.0,
        use_active_for_splits        = true,
        default_split_ratio          = 1.0,
        split_bias                   = 0,
        precise_mouse_move           = false,
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
