WM := dwm
TERMINAL := st
EDITOR := kak
MULTIPLEXER := tmux

STOW_CMD := stow --ignore=install --ignore=tags --ignore='\.kak.*'

MODULES := awesome bash bin bspwm dunst dvtm dzen emacs git i3 irssi kak lemonbar mutt mail ncmpcpp newsbeuter polybar sh st sxhkd termite tig tmux todotxt uzbl vim vis weechat xdg xmonad xorg zsh

.PHONY: $(MODULES) core desktop server

desktop: core sh git xdg $(WM) $(TERMINAL) $(EDITOR) dunst irssi mutt ncmpcpp newsbeuter todotxt

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
kak: sh $(MULTIPLEXER)
emacs:
vim:
vis: bin

# window managers
bspwm: sxhkd xorg
i3: xorg
xmonad: xorg
awesome: xorg

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
mutt: mail
ncmpcpp:
newsbeuter:
todotxt:
tig: git

$(MODULES):
	$(STOW_CMD) $@

dwm: xorg
	[ -d ~/src/c/dwm ] || git clone https://git.suckless.org/dwm ~/src/c/dwm
	rm -f ~/src/c/dwm/config.mk
	stow $@
	@cd ~/src/c/dwm; \
	for f in $$(find -L patches -name '*.diff' | sort); do \
		if ! patch -R -p1 -s -f --dry-run -i $$f >/dev/null; then \
			echo "Applying patch $$f"; \
			patch -s -f -p1 -i $$f; \
			if ! [ $$? -eq 0 ]; then \
				echo "Could not apply patch $$f"; \
				exit 1; \
			fi\
		fi \
	done; \
	cd -

core: core/install
	exec ./core/install
	$(STOW_CMD) $@

