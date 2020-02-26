PROJECTS = dwm st surf tabbed dmenu
PROJECT_CONTAINING_DIR = ${HOME}/src/c/

PROJECT_DIRS = $(patsubst %,$(PROJECT_CONTAINING_DIR)%,$(PROJECTS))

install: $(PROJECT_DIRS) tcolor
	ln tcolor ${HOME}/bin/tcolor

$(PROJECT_DIRS): hconfig.h themes
	cd $@; \
	$(MAKE); sudo $(MAKE) install; \
	cd -

tcolor: tcolor.c hconfig.h themes
	$(CC) -o $@ $<

