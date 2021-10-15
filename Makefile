WM := river
TERMINAL := alacritty
EDITOR := kak
MULTIPLEXER := tmux

STOW_CMD := stow --ignore=install --ignore=tags --ignore='\.kak.*'

MODULES := \
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
	sh \
	st \
	sxhkd \
	termite \
	tig \
	tmux \
	todotxt \
	uzbl \
	vim \
	vis \
	weechat \
	xdg \
	xmonad \
	xorg \
	zsh \

.PHONY: $(MODULES) core desktop server

desktop: core sh git xdg $(TERMINAL) $(EDITOR) dunst irssi mutt ncmpcpp newsbeuter todotxt

server: core sh git $(EDITOR) $(MULTIPLEXER) tig

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
vim:
vis: bin

# window managers
bspwm: sxhkd xorg
i3: xorg
xmonad: xorg
awesome: xorg
river: core

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

$(MODULES):
	$(STOW_CMD) $@

dwm: xorg
	[ -d ~/src/c/dwm ] || git clone https://git.suckless.org/dwm ~/src/c/dwm
	@cd ~/src/c/dwm; \
		patchdir patches \
	cd -
	rm -f ~/src/c/dwm/config.mk
	stow $@

core: core/install
	exec ./core/install
	$(STOW_CMD) $@

kak: sh $(MULTIPLEXER)
	$(STOW_CMD) $@
	@ln -s /usr/share/kak/rc $(HOME)/.config/kak/autoload/standard-libs
