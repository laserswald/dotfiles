
(local gears (require :gears))
(local awful (require :awful))
(local hotkeys_popup (require :awful.hotkeys_popup))
(local wibox (require :wibox))
(local beautiful (require :beautiful))
(local naughty (require :naughty))
(local menubar (require :menubar))

(require :awful.autofocus)
(require :awful.hotkeys_popup.keys)

;; Error handling
;;
;; Check if awesome encountered an error during startup and fell back to
;; another config (This code will only ever execute for the fallback config)
(when awesome.startup_errors
  (naughty.notify [:preset naughty.config.presets.critical
                   :title  "Oops. There were errors during startup."
                   :text   awesome.startup_errors]))

(local awesome-config-dir (awful.util.get_configuration_dir))

(local modkey :Mod4)
(local terminal :kitty)
(local editor :kak)
(local editor-cmd (.. terminal :-e editor))
(local tags [:main :web :media :work :chat :fun :srv :etc :bg])

(local mainmenu 
  (awful.menu
    {:items [["terminal" terminal]
             ["restart"  awesome.restart]
             ["quit"     awesome.quit]]}))

(local taglist_buttons 
  (gears.table.join 
    (awful.button [] 1 #($:view_only))
    (awful.button [modkey] 1 (fn [t] (when client.focus (client.focus:move_to_tag t))))
    (awful.button [] 3 awful.tag.viewtoggle)
    (awful.button [modkey] 3 (fn [t] (when client.focus (client.focus:toggle_tag t))))
    (awful.button [] 4 #[awful.tag.viewnext $.screen])
    (awful.button [] 5 #[awful.tag.viewprev $.screen])))

(local tasklist_buttons 
  (gears.table.join 
    (awful.button [] 1 (fn [c] 
                         (if (= c client.focus)
                           (set c.minimized true)
                           (c:emit_signal "request::activate" "tasklist" {:raise true})))
    (awful.button [] 3 #(awful.menu.client_list {:theme {:width 250}}))
    (awful.button [] 4 #(awful.client.focus.byidx 1))
    (awful.button [] 4 #(awful.client.focus.byidx -1)))))

(beautiful.init (require :theme))

;; Table of layouts to cover with awful.layout.inc, order matters.
(tset awful "layout" "layouts" [awful.layout.suit.floating
                               awful.layout.suit.tile
                               awful.layout.suit.tile.left
                               awful.layout.suit.tile.bottom
                               awful.layout.suit.tile.top
                               awful.layout.suit.fair
                               awful.layout.suit.fair.horizontal
                               awful.layout.suit.spiral
                               awful.layout.suit.spiral.dwindle
                               awful.layout.suit.max
                               awful.layout.suit.max.fullscreen
                               awful.layout.suit.magnifier
                               awful.layout.suit.corner.nw]) 

(fn set-wallpaper [s] 
  (var wallpaper beautiful.wallpaper)
  (when wallpaper
    (when (= (type wallpaper) :function)
      (set wallpaper (wallpaper s)))
    (gears.wallpaper.maximized wallpaper s)))

(fn setup-tags [s]
  (awful.tag tags s awful.layout.layouts)) 

(fn make-layout-switch-button [n inc]
  (awful.button {} n #[awful.layout.inc inc]))

(fn setup-bar [s]
  (let [layoutbox (awful.widget.layoutbox s)
        promptbox (awful.widget.prompt)
        buttontab (gears.table.join 
                    (make-layout-switch-button 1 1)
                    (make-layout-switch-button 3 -1)
                    (make-layout-switch-button 4 1)
                    (make-layout-switch-button 5 -1))
        taglist   (awful.widget.taglist {:screen s
                                         :filter awful.widget.taglist.filter.all
                                         :buttons taglist_buttons})
        tasklist  (awful.widget.tasklist {:screen s
                                          :filter awful.widget.tasklist.filter.currenttags
                                          :buttons tasklist_buttons})]
    (layoutbox:buttons buttontab)
    (var wibar (awful.wibar {:position "top" :screen s}))
    (wibar:setup {:layout wibox.layout.align.horizontal
                  1 {:layout wibox.layout.fixed.horizontal
                     1 taglist
                     2 promptbox}
                  2 tasklist
                  3 {:layout wibox.layout.fixed.horizontal
                     1 (wibox.widget.systray)}})))

(fn setup-screen [s]
  (set-wallpaper s)
  (setup-tags s)
  (setup-bar s))        

(screen.connect_signal "property::geometry" set-wallpaper)
(awful.screen.connect_for_each_screen setup-screen)

(root.buttons 
  (gears.table.join 
    (awful.button {} 3 (fn [] (mainmenu:toggle)))
    (awful.button {} 4 awful.tag.viewnext)
    (awful.button {} 5 awful.tag.viewprev)))

;     -- Create an imagebox widget which will contain an icon indicating which layout we're using.
;     -- We need one layoutbox per screen.
;     s.mylayoutbox = awful.widget.layoutbox(s)
;     s.mylayoutbox:buttons(gears.table.join(
;                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
;                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
;                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
;                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))
;     -- Create a taglist widget
;     s.mytaglist = awful.widget.taglist {
;         screen  = s,
;         filter  = awful.widget.taglist.filter.all,
;         buttons = taglist_buttons
;     }
; 
;     -- Create a tasklist widget
;     s.mytasklist = awful.widget.tasklist {
;         screen  = s,
;         filter  = awful.widget.tasklist.filter.currenttags,
;         buttons = tasklist_buttons
;     }
; 
;     -- Create the wibox
;     s.mywibox = awful.wibar({ position = "top", screen = s })
; 
;     -- Add widgets to the wibox
;     s.mywibox:setup {
;         layout = wibox.layout.align.horizontal,
;         { -- Left widgets
;             layout = wibox.layout.fixed.horizontal,
;             s.mytaglist,
;             s.mypromptbox,
;         },
;         s.mytasklist, -- Middle widget
;         { -- Right widgets
;             layout = wibox.layout.fixed.horizontal,
;             wibox.widget.systray(),
;             mytextclock,
;             s.mylayoutbox,
;         },
;     }
; end)
; -- }}}
