# Guix stuff lives here.

GUIX = $(HOME)/.config/guix/current/bin/guix 
GUIX_HOME = $(GUIX) home -L guix-modules -c 4 -v 5

.PHONY: reconfigure
reconfigure:
	$(GUIX_HOME) reconfigure home-configuration.scm
	# Hot reload my emacs configuration.
	emacsclient -e '(lazr-reload-config)'

.PHONY: container
container:
	$(GUIX_HOME) container home-configuration.scm --network -- zsh

.PHONY: repl
repl:
	$(GUIX) repl -L ./guix-modules

ifdef LEGACY

include legacy.mk
all: core

else # NOT LEGACY

all: reconfigure

endif # LEGACY
