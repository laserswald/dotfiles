#!/bin/sh

# luarocks.sh: enable executing LuaRocks installed programs and modules

if which 'luarocks-5.1' 2>&1 >/dev/null; then
	eval $(luarocks-5.1 path --bin)
fi
