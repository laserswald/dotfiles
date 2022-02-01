WM := river
TERMINAL := alacritty
EDITOR := kak
MULTIPLEXER := tmux

STOW_CMD := stow --ignore=install --ignore=tags --ignore='\.kak.*'

SCRIPT_MODULES := core vim tmux sh git

STOW_MODULES := \
	alacritty \
	awesome \
	bash \
	bin \
	bspwm \
	dunst \
	dvtm \
	dzen \
	emacs \
	git \
	i3 \
	irssi \
	kak \
	kitty \
	lemonbar \
	mail \
	mutt \
	ncmpcpp \
	newsbeuter \
	polybar \
	river \
	st \
	sway \
	sxhkd \
	termite \
	tig \
	todotxt \
	uzbl \
	vis \
	weechat \
	xdg \
	xmonad \
	xorg \
	zsh

MODULES := $(SCRIPT_MODULES) $(STOW_MODULES)

.PHONY: $(MODULES) desktop server

server: sh git vim tmux
desktop: server xdg $(TERMINAL) $(EDITOR) tig dunst irssi mutt ncmpcpp newsbeuter todotxt

# primary stuff
bin: core sh
mail: bin
git: core
xorg: core
xdg: xorg

# shells
sh:
bash: sh
zsh: sh

# editors
emacs:
vis: bin

# window managers
bspwm: sxhkd xorg
i3: xorg
xmonad: xorg
awesome: xorg
river: core
sway: core

# desktop environment
dunst: xorg
dzen: xorg
lemonbar: xorg
polybar: xorg
sxhkd: xorg
uzbl: xorg

# terminals
alacritty: xorg
st: xorg
termite: xorg
kitty: xorg

# terminal applications
dvtm: core
tmux: core sh
irssi: core
weechat: core
mutt: mail
ncmpcpp:
newsbeuter:
todotxt:
tig: git
dwm: xorg

$(STOW_MODULES):
	$(STOW_CMD) $@

$(SCRIPT_MODULES):
	env RC_DIR=$(HOME)/etc ./$@/install

