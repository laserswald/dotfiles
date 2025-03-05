#!/bin/sh
. "$HOME/.local/lib/sh/path.sh"
. "$HOME/.local/lib/sh/command_exists.sh"

# luarocks.sh: enable executing LuaRocks installed programs and modules

if command_exists luarocks-5.1; then
    eval $(luarocks-5.1 path --bin)
elif command_exists 'luarocks'; then
    eval $(luarocks path --bin)
fi

insert_path "$HOME/.luarocks/bin"
