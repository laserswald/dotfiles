# Guix stuff lives here.

GUIX = $(HOME)/.config/guix/current/bin/guix 
GUIX_HOME = $(GUIX) home -L guix-modules -c 4 -v 9

.PHONY: all
all: reconfigure
	fc-cache -f
	test -S "${XDG_RUNTIME_DIR}/emacs/server" && emacsclient -e '(lazr/reload-config)' || true
	pgrep waybar && pkill -SIGUSR2 waybar
	pgrep river && river-reload
	pgrep kanshi && kanshictl reload
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
