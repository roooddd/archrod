-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
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