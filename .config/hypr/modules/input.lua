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