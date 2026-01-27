# Guix stuff lives here.

GUIX = $(HOME)/.config/guix/current/bin/guix 
GUIX_HOME = $(GUIX) home -L guix-modules -c 4

.PHONY: all
all: reconfigure
	if test -S "${XDG_RUNTIME_DIR}/emacs/server"; then emacsclient -e '(lazr/reload-config)'; fi
	if pgrep waybar; then pkill -SIGUSR2 waybar; fi
	if pgrep river; then river-reload; fi
	if pgrep kanshi; then kanshictl reload; fi
	if pgrep Hyprland || pgrep hyprland; then hyprctl reload; fi

.PHONY: container
container:
	$(GUIX_HOME) container home-configuration.scm --network -- zsh

.PHONY: repl
repl:
	$(GUIX) repl -L ./guix-modules -L .

.PHONY: reconfigure
reconfigure: update-submodules install-secrets
	$(GUIX_HOME) reconfigure home-configuration.scm

.PHONY: update-submodules
update-submodules:
	git submodule update --init --recursive 

.PHONY: install-secrets
install-secrets: ~/.authinfo

~/.authinfo: secrets/authinfo.gpg
	gpg -d < $< > $@

.PHONY: refresh-theme
refresh-theme: reconfigure

ifdef LEGACY
include legacy.mk
all: core
else # NOT LEGACY
all: reconfigure
endif # LEGACY
