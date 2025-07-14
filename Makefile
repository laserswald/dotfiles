# Guix stuff lives here.

GUIX = $(HOME)/.config/guix/current/bin/guix 
GUIX_HOME = $(GUIX) home -L guix-modules -c 4 -v 5

.PHONY: all
all: reconfigure
	fc-cache -f -v 
	emacsclient -e '(lazr-reload-config)'
	# Refresh Waybar
	pkill -SIGUSR2 waybar

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
