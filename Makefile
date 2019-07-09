WM := dwm
TERMINAL := st
EDITOR := kak
MULTIPLEXER := tmux

MODULES := bash bin bspwm dunst dvtm dwm dzen emacs git i3 irssi kak lemonbar mutt ncmpcpp newsbeuter polybar sh st sxhkd termite tig tmux todotxt uzbl vim vis weechat xdg xmonad xorg zsh

.PHONY: $(MODULES) core desktop

desktop: core sh git xdg $(WM) $(TERMINAL) $(EDITOR) dunst weechat mutt ncmpcpp newsbeuter todotxt

# primary stuff
bin: core sh
git: core
xorg: core
xdg: xorg

# shells
sh:  
bash: sh
zsh: sh

# editors
kak: sh $(MULTIPLEXER)
emacs:
vim:
vis: bin

# window managers
bspwm: sxhkd xorg
dwm: xorg
i3: xorg
xmonad: xorg

# desktop environment
dunst: xorg
dzen: xorg
lemonbar: xorg
polybar: xorg
sxhkd: xorg
uzbl: xorg

# terminals
st: xorg
termite: xorg

# terminal applications
dvtm: core
tmux:
irssi:
weechat:
mutt: 
ncmpcpp:
newsbeuter:
todotxt:
tig: git
$(MODULES):
	stow $@
	
core: core/install
	exec ./core/install

