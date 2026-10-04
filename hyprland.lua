-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  Hyprland Yapılandırması (Lua) - ThinkPad T420 / Arch Linux
--  Optimize Edildi: Türkçe Q, Hafif Efektler, Ergonomik Kısayollar, Akıllı Kurallar
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

------------------
---- MONITORS ----
------------------
-- Otomatik algılama (1366x768 @ 60Hz)
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})


---------------------
---- MY PROGRAMS ----
---------------------
local mainMod     = "SUPER"
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "rofi -show drun"


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("PATH", os.getenv("HOME") .. "/.local/bin:" .. (os.getenv("PATH") or "/usr/local/bin:/usr/bin"))


-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd(os.getenv("HOME") .. "/.local/bin/waybar-hover")
    hl.exec_cmd("dunst")
    hl.exec_cmd("nm-applet --indicator")
end)


-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,
        border_size = 1,

        col = {
            active_border   = "0xff6b5f8c",
            inactive_border = "0xff2a2438",
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 0, -- Tamamen boşluksuz ve düz kenarlar
        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled = false, -- Intel HD 3000 için gölgeler kapalı (performans)
        },

        blur = {
            enabled = false, -- Intel HD 3000 için bulanıklık kapalı (akıcılık ve pil tasarrufu)
        },
    },

    misc = {
        disable_hyprland_logo    = true,  -- Arka plan logosunu kapat
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
    },

    cursor = {
        no_warps = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },
})

-- Smart gaps: Ekranda tek pencere varken boşlukları sıfırlayarak tam ekran alanı sağlar
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })


--------------------
---- ANIMATIONS ----
--------------------
hl.config({ animations = { enabled = true } })
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

-- Hızlı ve hafif animasyonlar
hl.animation({ leaf = "windows",             enabled = true, speed = 4, bezier = "myBezier", style = "popin 85%" })
hl.animation({ leaf = "windowsOut",          enabled = true, speed = 4, bezier = "myBezier", style = "popin 85%" })
hl.animation({ leaf = "layers",              enabled = true, speed = 4, bezier = "myBezier", style = "fade" })
hl.animation({ leaf = "workspaces",          enabled = true, speed = 4, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 4, bezier = "myBezier", style = "fade" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 4, bezier = "myBezier", style = "fade" })


---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout    = "tr,us",
        kb_options   = "grp:alt_shift_toggle",
        repeat_rate  = 40,
        repeat_delay = 250,
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll       = true,
            disable_while_typing = true,
            tap_to_click         = true,
        },
    },
})

-- ThinkPad TrackPoint hassasiyet ayarı
hl.device({
    name        = "tpps/2-ibm-trackpoint",
    sensitivity = 0.2,
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


---------------------
---- KEYBINDINGS ----
---------------------
-- Temel Uygulamalar ve Pencere Yönetimi
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Pencere Odaklama (Focus - Yön Tuşları)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Pencere Boyutlandırma (Resize - SHIFT + Yön Tuşları)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -40, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 40,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 40,  relative = true }), { repeating = true })

-- Pencere Taşıma / Yer Değiştirme (Move - CTRL + Yön Tuşları)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "down" }))

-- Scratchpad (Gizli / Hızlı Terminal)
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:scratch" }))

-- Çalışma Alanları (Workspaces 1-10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse ile Pencere Taşıma ve Boyutlandırma
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Ses Kontrolleri (wpctl)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

-- Medya Tuşları (playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Ekran Parlaklığı
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("change-brightness up"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("change-brightness down"), { locked = true, repeating = true })



--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- Uygulamaların maximize isteklerini yoksay
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- XWayland drag sorununu düzelt
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

-- Dosya seçme / kaydetme pencerelerini otomatik float yap ve ortala
hl.window_rule({
    name  = "float_portals",
    match = { class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-gnome|xdg-desktop-portal-kde)$" },
    float = true, center = true, size = {850, 520},
})

hl.window_rule({
    name  = "float_file_dialogs",
    match = { title = "^(Open|Save|Save As|Open File|Save File|Open Folder|Choose Files|Select File|Choose File|Browse)(.*)$" },
    float = true, center = true, size = {850, 520},
})

-- Ses mikseri, ağ editörü ve polkit pencerelerini float yap
hl.window_rule({
    name  = "float_dialog_class",
    match = { class = "^(pavucontrol|nm-connection-editor|blueman-manager|file-roller|polkit-gnome-authentication-agent-1)$" },
    float = true, center = true,
})

-- Scratchpad: Boş açıldığında terminali yükle
hl.workspace_rule({
    workspace = "special:scratch",
    on_created_empty = "kitty",
})
