# Guix stuff lives here.

GUIX = $(HOME)/.config/guix/current/bin/guix 
GUIX_HOME = $(GUIX) home -L guix-modules -c 4 -v 5

.PHONY: reconfigure
reconfigure:
	git submodule update --init --recursive 
	$(GUIX_HOME) reconfigure home-configuration.scm
	emacsclient -e '(lazr-reload-config)'
	sv restart $(HOME)/var/sv/waybar
	river-reload
	kanshictl reload

.PHONY: container
container:
	$(GUIX_HOME) container home-configuration.scm --network -- zsh

.PHONY: repl
repl:
	$(GUIX) repl -L ./guix-modules -L .

ifdef LEGACY

include legacy.mk
all: core

else # NOT LEGACY

all: reconfigure

endif # LEGACY
