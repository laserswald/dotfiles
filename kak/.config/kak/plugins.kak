#
# Plugins.
#

# Initialize the plugin manager.
source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "andreyorst/plug.kak" noload

# Fuzzy finder. 
plug "andreyorst/fzf.kak" config %{
	
	map global goto F <esc>:fzf-file<ret> -docstring "Find a file"
	map global goto b <esc>:fzf-buffer<ret> -docstring "Find a file"
}

plug "andreyorst/tagbar.kak" config %{
	hook global WinSetOption filetype=tagbar %{
		remove-highlighter window/wrap
	}
}

# TODO: make sure this gets configured properly before enabling
# plug "alexherbo2/auto-pairs.kak"

plug "andreyorst/powerline.kak" config %{
	powerline-start
}

plug "TeddyDD/kakoune-wiki" config %{
	wiki-setup %sh{ echo "$HOME/org" }
    declare-user-mode notes
    map global user n :<space>enter-user-mode<space>notes<ret>
}

try %{
	plug "eraserhd/parinfer-rust" do %{
		cargo install --force --path .
	} config %{
		hook global WinSetOption filetype=(clojure|lisp|scheme|racket) %{
			parinfer-enable-window -smart
		}
	}
}

echo -debug "loaded"

plug "occivink/kakoune-snippets"

echo -debug "loaded plugins"
