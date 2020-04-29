
(local gears (require :gears))
(local awful (require :awful))
(local hotkeys_popup (require :awful.hotkeys_popup))
(local wibox (require :wibox))
(local beautiful (require :beautiful))
(local naughty (require :naughty))
(local naughty (require :naughty))
(local menubar (require :menubar))

(require :awful.autofocus)
(require :awful.hotkeys_popup.keys)

;; Error handling
;;
;; Check if awesome encountered an error during startup and fell back to
;; another config (This code will only ever execute for the fallback config)
(when (. awesome startup_errors)
  (naughty.notify [preset (. naughty config presets critical)
                   title  "Oops. There were errors during startup."
                   text   (. awesome startup_errors)))

(local terminal :kitty)
(local editor :kak)
(local editor_cmd (.. terminal :-e editor))

(tset beautiful wallpaper "/home/ben/blue-universe-956981.jpg")
