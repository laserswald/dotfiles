#!/bin/sh

# luarocks.sh: enable executing LuaRocks installed programs and modules

if command -v 'luarocks-5.1' >/dev/null; then
	eval $(luarocks-5.1 path --bin)
elif command -v 'luarocks' >/dev/null; then
    eval $(luarocks path --bin)
fi

insert_path "$HOME/.luarocks/bin"
