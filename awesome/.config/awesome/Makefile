.DEFAULT: all
.SUFFIXES:
.SUFFIXES: .lua .fnl

all: rc.lua theme.lua

.fnl.lua:
	fennel --compile $^ > $@

clean:
	rm *.lua
