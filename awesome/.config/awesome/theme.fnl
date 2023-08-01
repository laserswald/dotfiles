
(local font "Fira Code 9")

(local opacity 0.5)

(local gruvbox 
  { :dark0_hard       "#1d2021"
    :dark0            "#282828"
    :dark0_soft       "#32302f"
    :dark1            "#3c3836"
    :dark2            "#504945"
    :dark3            "#665c54"
    :dark4            "#7c6f64"
    :gray_245         "#928374"
    :gray_244         "#928374"
    :light0_hard      "#f9f5d7"
    :light0           "#fbf1c7"
    :light0_soft      "#f2e5bc"
    :light1           "#ebdbb2"
    :light2           "#d5c4a1"
    :light3           "#bdae93"
    :light4           "#a89984"
    :bright_red       "#fb4934"
    :bright_green     "#b8bb26"
    :bright_yellow    "#fabd2f"
    :bright_blue      "#83a598"
    :bright_purple    "#d3869b"
    :bright_aqua      "#8ec07c"
    :bright_orange    "#fe8019"
    :neutral_red      "#cc241d"
    :neutral_green    "#98971a"
    :neutral_yellow   "#d79921"
    :neutral_blue     "#458588"
    :neutral_purple   "#b16286"
    :neutral_aqua     "#689d6a"
    :neutral_orange   "#d65d0e"
    :faded_red        "#9d0006"
    :faded_green      "#79740e"
    :faded_yellow     "#b57614"
    :faded_blue       "#076678"
    :faded_purple     "#8f3f71"
    :faded_aqua       "#427b58"
    :faded_orange     "#af3a03" }) 

(fn aclr [n]
  (.. (. gruvbox n) 
      (string.format "%X" (math.floor (* 255 opacity)))))

(fn clr [n]
  (. gruvbox n))

(local foc (clr :neutral_blue))

(local theme { ;; Default variables
  ;; theme.font = nil
  : font
  ;; theme.wallpaper = nil
  :wallpaper "/home/ben/Telegram Desktop/landscapething.png"

  ;; arcchart
  ;; theme.arcchart_border_color = nil
  ;; theme.arcchart_color = nil
  ;; theme.arcchart_border_width = nil
  ;; theme.arcchart_paddings = nil
  ;; theme.arcchart_thickness = nil

  ;; awesome
  ;; theme.awesome_icon = nil

  ;; bg\
  :fg_focus (clr :neutral_blue)
  :bg_focus (aclr :faded_blue)

  :fg_minimize (clr :gray_245)
  :bg_minimize (aclr :dark0)

  :fg_normal (clr :light0)
  :bg_normal (aclr :dark0)

  :fg_urgent (clr :neutral_orange)
  :bg_urgent (aclr :dark0)

  :bg_systray (aclr :dark0)

  ;; border\
  :border_focus (clr :neutral_blue)
  :border_marked "#ff0000"
  :border_normal "#ffffff"
  :border_width 0
  ;; theme.border_focus = nil
  ;; theme.border_marked = nil
  ;; theme.border_normal = nil
  ;; theme.border_width = nil

  ;; calendar\
  ;; theme.calendar_style = nil
  ;; theme.calendar_font = nil
  ;; theme.calendar_spacing = nil
  ;; theme.calendar_week_numbers = nil
  ;; theme.calendar_start_sunday = nil
  ;; theme.calendar_long_weekdays = nil

  ;; checkbox\
  ;; theme.checkbox_border_width = nil
  ;; theme.checkbox_bg = nil
  ;; theme.checkbox_border_color = nil
  ;; theme.checkbox_check_border_color = nil
  ;; theme.checkbox_check_border_width = nil
  ;; theme.checkbox_check_color = nil
  ;; theme.checkbox_shape = nil
  ;; theme.checkbox_check_shape = nil
  ;; theme.checkbox_paddings = nil
  ;; theme.checkbox_color = nil

  ;; column\
  ;; theme.column_count = nil

  ;; cursor\
  ;; theme.cursor_mouse_resize = nil
  ;; theme.cursor_mouse_move = nil

  ;; enable\
  ;; theme.enable_spawn_cursor = nil

  ;; fg\
  ;; theme.fg_focus = nil
  ;; theme.fg_minimize = nil
  ;; theme.fg_normal = nil
  ;; theme.fg_urgent = nil

  ;; fullscreen\
  ;; theme.fullscreen_hide_border = nil

  ;; gap\
  ;; theme.gap_single_client = nil

  ;; graph\
  ;; theme.graph_bg = nil
  ;; theme.graph_fg = nil
  ;; theme.graph_border_color = nil

  ;; hotkeys\
  ;; theme.hotkeys_bg = nil
  ;; theme.hotkeys_fg = nil
  ;; theme.hotkeys_border_width = nil
  ;; theme.hotkeys_border_color = nil
  ;; theme.hotkeys_shape = nil
  ;; theme.hotkeys_modifiers_fg = nil
  ;; theme.hotkeys_label_bg = nil
  ;; theme.hotkeys_label_fg = nil
  ;; theme.hotkeys_font = nil
  ;; theme.hotkeys_description_font = nil
  ;; theme.hotkeys_group_margin = nil

  ;; icon\
  ;; theme.icon_theme = nil

  ;; layout\
  ;; theme.layout_cornernw = nil
  ;; theme.layout_cornerne = nil
  ;; theme.layout_cornersw = nil
  ;; theme.layout_cornerse = nil
  ;; theme.layout_fairh = nil
  ;; theme.layout_fairv = nil
  ;; theme.layout_floating = nil
  ;; theme.layout_magnifier = nil
  ;; theme.layout_max = nil
  ;; theme.layout_fullscreen = nil
  ;; theme.layout_spiral = nil
  ;; theme.layout_dwindle = nil
  ;; theme.layout_tile = nil
  ;; theme.layout_tiletop = nil
  ;; theme.layout_tilebottom = nil
  ;; theme.layout_tileleft = nil

  ;; layoutlist\
  ;; theme.layoutlist_fg_normal = nil
  ;; theme.layoutlist_bg_normal = nil
  ;; theme.layoutlist_fg_selected = nil
  ;; theme.layoutlist_bg_selected = nil
  ;; theme.layoutlist_disable_icon = nil
  ;; theme.layoutlist_disable_name = nil
  ;; theme.layoutlist_font = nil
  ;; theme.layoutlist_align = nil
  ;; theme.layoutlist_font_selected = nil
  ;; theme.layoutlist_spacing = nil
  ;; theme.layoutlist_shape = nil
  ;; theme.layoutlist_shape_border_width = nil
  ;; theme.layoutlist_shape_border_color = nil
  ;; theme.layoutlist_shape_selected = nil
  ;; theme.layoutlist_shape_border_width_selected = nil
  ;; theme.layoutlist_shape_border_color_selected = nil

  ;; master\
  ;; theme.master_width_factor = nil
  ;; theme.master_fill_policy = nil
  ;; theme.master_count = nil

  ;; maximized\
  ;; theme.maximized_honor_padding = nil
  ;; theme.maximized_hide_border = nil

  ;; menu\
  ;; theme.menu_submenu_icon = nil
  ;; theme.menu_font = nil
  ;; theme.menu_height = nil
  ;; theme.menu_width = nil
  ;; theme.menu_border_color = nil
  ;; theme.menu_border_width = nil
  ;; theme.menu_fg_focus = nil
  ;; theme.menu_bg_focus = nil
  ;; theme.menu_fg_normal = nil
  ;; theme.menu_bg_normal = nil
  ;; theme.menu_submenu = nil

  ;; menubar\
  ;; theme.menubar_fg_normal = nil
  ;; theme.menubar_bg_normal = nil
  ;; theme.menubar_border_width = nil
  ;; theme.menubar_border_color = nil
  ;; theme.menubar_fg_normal = nil
  ;; theme.menubar_bg_normal = nil

  ;; notification\
  ;; theme.notification_font = nil
  ;; theme.notification_bg = nil
  ;; theme.notification_fg = nil
  ;; theme.notification_border_width = nil
  ;; theme.notification_border_color = nil
  ;; theme.notification_shape = nil
  ;; theme.notification_opacity = nil
  ;; theme.notification_margin = nil
  ;; theme.notification_width = nil
  ;; theme.notification_height = nil
  ;; theme.notification_max_width = nil
  ;; theme.notification_max_height = nil
  ;; theme.notification_icon_size = nil

  ;; piechart\
  ;; theme.piechart_border_color = nil
  ;; theme.piechart_border_width = nil
  ;; theme.piechart_colors = nil

  ;; progressbar\
  ;; theme.progressbar_bg = nil
  ;; theme.progressbar_fg = nil
  ;; theme.progressbar_shape = nil
  ;; theme.progressbar_border_color = nil
  ;; theme.progressbar_border_width = nil
  ;; theme.progressbar_bar_shape = nil
  ;; theme.progressbar_bar_border_width = nil
  ;; theme.progressbar_bar_border_color = nil
  ;; theme.progressbar_margins = nil
  ;; theme.progressbar_paddings = nil

  ;; prompt\
  ;; theme.prompt_fg_cursor = nil
  ;; theme.prompt_bg_cursor = nil
  ;; theme.prompt_font = nil
  ;; theme.prompt_fg = nil
  ;; theme.prompt_bg = nil

  ;; radialprogressbar\
  ;; theme.radialprogressbar_border_color = nil
  ;; theme.radialprogressbar_color = nil
  ;; theme.radialprogressbar_border_width = nil
  ;; theme.radialprogressbar_paddings = nil

  ;; separator\
  ;; theme.separator_thickness = nil
  ;; theme.separator_border_color = nil
  ;; theme.separator_border_width = nil
  ;; theme.separator_span_ratio = nil
  ;; theme.separator_color = nil
  ;; theme.separator_shape = nil

  ;; slider\
  ;; theme.slider_bar_border_width = nil
  ;; theme.slider_bar_border_color = nil
  ;; theme.slider_handle_border_color = nil
  ;; theme.slider_handle_border_width = nil
  ;; theme.slider_handle_width = nil
  ;; theme.slider_handle_color = nil
  ;; theme.slider_handle_shape = nil
  ;; theme.slider_bar_shape = nil
  ;; theme.slider_bar_height = nil
  ;; theme.slider_bar_margins = nil
  ;; theme.slider_handle_margins = nil
  ;; theme.slider_bar_color = nil

  ;; snap\
  ;; theme.snap_bg = nil
  ;; theme.snap_border_width = nil
  ;; theme.snap_shape = nil

  ;; snapper\
  ;; theme.snapper_gap = nil

  ;; systray\
  ;; theme.systray_icon_spacing = nil

  ;; taglist\
  ;; theme.taglist_fg_focus = nil
  ;; theme.taglist_bg_focus = nil
  ;; theme.taglist_fg_urgent = nil
  ;; theme.taglist_bg_urgent = nil
  ;; theme.taglist_bg_occupied = nil
  ;; theme.taglist_fg_occupied = nil
  ;; theme.taglist_bg_empty = nil
  ;; theme.taglist_fg_empty = nil
  ;; theme.taglist_bg_volatile = nil
  ;; theme.taglist_fg_volatile = nil
  ;; theme.taglist_squares_sel = nil
  ;; theme.taglist_squares_unsel = nil
  ;; theme.taglist_squares_sel_empty = nil
  ;; theme.taglist_squares_unsel_empty = nil
  ;; theme.taglist_squares_resize = nil
  ;; theme.taglist_disable_icon = nil
  ;; theme.taglist_font = nil
  ;; theme.taglist_spacing = nil
  ;; theme.taglist_shape = nil
  ;; theme.taglist_shape_border_width = nil
  ;; theme.taglist_shape_border_color = nil
  ;; theme.taglist_shape_empty = nil
  ;; theme.taglist_shape_border_width_empty = nil
  ;; theme.taglist_shape_border_color_empty = nil
  ;; theme.taglist_shape_focus = nil
  ;; theme.taglist_shape_border_width_focus = nil
  ;; theme.taglist_shape_border_color_focus = nil
  ;; theme.taglist_shape_urgent = nil
  ;; theme.taglist_shape_border_width_urgent = nil
  ;; theme.taglist_shape_border_color_urgent = nil
  ;; theme.taglist_shape_volatile = nil
  ;; theme.taglist_shape_border_width_volatile = nil
  ;; theme.taglist_shape_border_color_volatile = nil

  ;; tasklist\
  ;; theme.tasklist_fg_normal = nil
  ;; theme.tasklist_bg_normal = nil
  ;; theme.tasklist_fg_focus = nil
  ;; theme.tasklist_bg_focus = nil
  ;; theme.tasklist_fg_urgent = nil
  ;; theme.tasklist_bg_urgent = nil
  ;; theme.tasklist_fg_minimize = nil
  ;; theme.tasklist_bg_minimize = nil
  ;; theme.tasklist_bg_image_normal = nil
  ;; theme.tasklist_bg_image_focus = nil
  ;; theme.tasklist_bg_image_urgent = nil
  ;; theme.tasklist_bg_image_minimize = nil
  ;; theme.tasklist_disable_icon = nil
  ;; theme.tasklist_disable_task_name = nil
  ;; theme.tasklist_plain_task_name = nil
  ;; theme.tasklist_font = nil
  ;; theme.tasklist_align = nil
  ;; theme.tasklist_font_focus = nil
  ;; theme.tasklist_font_minimized = nil
  ;; theme.tasklist_font_urgent = nil
  ;; theme.tasklist_spacing = nil
  ;; theme.tasklist_shape = nil
  ;; theme.tasklist_shape_border_width = nil
  ;; theme.tasklist_shape_border_color = nil
  ;; theme.tasklist_shape_focus = nil
  ;; theme.tasklist_shape_border_width_focus = nil
  ;; theme.tasklist_shape_border_color_focus = nil
  ;; theme.tasklist_shape_minimized = nil
  ;; theme.tasklist_shape_border_width_minimized = nil
  ;; theme.tasklist_shape_border_color_minimized = nil
  ;; theme.tasklist_shape_urgent = nil
  ;; theme.tasklist_shape_border_width_urgent = nil
  ;; theme.tasklist_shape_border_color_urgent = nil

  ;; titlebar\
  ;; theme.titlebar_fg_normal = nil
  ;; theme.titlebar_bg_normal = nil
  ;; theme.titlebar_bgimage_normal = nil
  ;; theme.titlebar_fg = nil
  ;; theme.titlebar_bg = nil
  ;; theme.titlebar_bgimage = nil
  ;; theme.titlebar_fg_focus = nil
  ;; theme.titlebar_bg_focus = nil
  ;; theme.titlebar_bgimage_focus = nil
  ;; theme.titlebar_floating_button_normal = nil
  ;; theme.titlebar_maximized_button_normal = nil
  ;; theme.titlebar_minimize_button_normal = nil
  ;; theme.titlebar_minimize_button_normal_hover = nil
  ;; theme.titlebar_minimize_button_normal_press = nil
  ;; theme.titlebar_close_button_normal = nil
  ;; theme.titlebar_close_button_normal_hover = nil
  ;; theme.titlebar_close_button_normal_press = nil
  ;; theme.titlebar_ontop_button_normal = nil
  ;; theme.titlebar_sticky_button_normal = nil
  ;; theme.titlebar_floating_button_focus = nil
  ;; theme.titlebar_maximized_button_focus = nil
  ;; theme.titlebar_minimize_button_focus = nil
  ;; theme.titlebar_minimize_button_focus_hover = nil
  ;; theme.titlebar_minimize_button_focus_press = nil
  ;; theme.titlebar_close_button_focus = nil
  ;; theme.titlebar_close_button_focus_hover = nil
  ;; theme.titlebar_close_button_focus_press = nil
  ;; theme.titlebar_ontop_button_focus = nil
  ;; theme.titlebar_sticky_button_focus = nil
  ;; theme.titlebar_floating_button_normal_active = nil
  ;; theme.titlebar_floating_button_normal_active_hover = nil
  ;; theme.titlebar_floating_button_normal_active_press = nil
  ;; theme.titlebar_maximized_button_normal_active = nil
  ;; theme.titlebar_maximized_button_normal_active_hover = nil
  ;; theme.titlebar_maximized_button_normal_active_press = nil
  ;; theme.titlebar_ontop_button_normal_active = nil
  ;; theme.titlebar_ontop_button_normal_active_hover = nil
  ;; theme.titlebar_ontop_button_normal_active_press = nil
  ;; theme.titlebar_sticky_button_normal_active = nil
  ;; theme.titlebar_sticky_button_normal_active_hover = nil
  ;; theme.titlebar_sticky_button_normal_active_press = nil
  ;; theme.titlebar_floating_button_focus_active = nil
  ;; theme.titlebar_floating_button_focus_active_hover = nil
  ;; theme.titlebar_floating_button_focus_active_press = nil
  ;; theme.titlebar_maximized_button_focus_active = nil
  ;; theme.titlebar_maximized_button_focus_active_hover = nil
  ;; theme.titlebar_maximized_button_focus_active_press = nil
  ;; theme.titlebar_ontop_button_focus_active = nil
  ;; theme.titlebar_ontop_button_focus_active_hover = nil
  ;; theme.titlebar_ontop_button_focus_active_press = nil
  ;; theme.titlebar_sticky_button_focus_active = nil
  ;; theme.titlebar_sticky_button_focus_active_hover = nil
  ;; theme.titlebar_sticky_button_focus_active_press = nil
  ;; theme.titlebar_floating_button_normal_inactive = nil
  ;; theme.titlebar_floating_button_normal_inactive_hover = nil
  ;; theme.titlebar_floating_button_normal_inactive_press = nil
  ;; theme.titlebar_maximized_button_normal_inactive = nil
  ;; theme.titlebar_maximized_button_normal_inactive_hover = nil
  ;; theme.titlebar_maximized_button_normal_inactive_press = nil
  ;; theme.titlebar_ontop_button_normal_inactive = nil
  ;; theme.titlebar_ontop_button_normal_inactive_hover = nil
  ;; theme.titlebar_ontop_button_normal_inactive_press = nil
  ;; theme.titlebar_sticky_button_normal_inactive = nil
  ;; theme.titlebar_sticky_button_normal_inactive_hover = nil
  ;; theme.titlebar_sticky_button_normal_inactive_press = nil
  ;; theme.titlebar_floating_button_focus_inactive = nil
  ;; theme.titlebar_floating_button_focus_inactive_hover = nil
  ;; theme.titlebar_floating_button_focus_inactive_press = nil
  ;; theme.titlebar_maximized_button_focus_inactive = nil
  ;; theme.titlebar_maximized_button_focus_inactive_hover = nil
  ;; theme.titlebar_maximized_button_focus_inactive_press = nil
  ;; theme.titlebar_ontop_button_focus_inactive = nil
  ;; theme.titlebar_ontop_button_focus_inactive_hover = nil
  ;; theme.titlebar_ontop_button_focus_inactive_press = nil
  ;; theme.titlebar_sticky_button_focus_inactive = nil
  ;; theme.titlebar_sticky_button_focus_inactive_hover = nil
  ;; theme.titlebar_sticky_button_focus_inactive_press = nil

  ;; tooltip\
  ;; theme.tooltip_border_color = nil
  ;; theme.tooltip_bg = nil
  ;; theme.tooltip_fg = nil
  ;; theme.tooltip_font = nil
  ;; theme.tooltip_border_width = nil
  ;; theme.tooltip_opacity = nil
  ;; theme.tooltip_shape = nil
  ;; theme.tooltip_align = nil

  ;; useless\
  ;; theme.useless_gap = nil
  ;; theme.useless_gap = nil

  ;; wibar\
  ;; theme.wibar_stretch = nil
  ;; theme.wibar_border_width = nil
  ;; theme.wibar_border_color = nil
  ;; theme.wibar_ontop = nil
  ;; theme.wibar_cursor = nil
  ;; theme.wibar_opacity = nil
  ;; theme.wibar_type = nil
  ;; theme.wibar_width = nil
  ;; theme.wibar_height = nil
  ;; theme.wibar_bg = nil
  ;; theme.wibar_bgimage = nil
  ;; theme.wibar_fg = nil
  ;; theme.wibar_shape = nil
  })

theme

