#
# Plugins.
#

# Initialize the plugin manager.
source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "robertmeta/plug.kak" noload

# Fuzzy finder. 
plug "andreyorst/fzf.kak" config %{
	require-module fzf
	set-option global fzf_file_command "ag -l -f --hidden --one-device --ignore .git"
}

plug "andreyorst/tagbar.kak" config %{
	hook global WinSetOption filetype=tagbar %{
		remove-highlighter window/wrap
	}
}

# TODO: make sure this gets configured properly before enabling
plug "alexherbo2/auto-pairs.kak" 

plug "andreyorst/powerline.kak" config %{
	powerline-start
}

plug "TeddyDD/kakoune-wiki" config %{
    wiki-setup %sh{ echo "$HOME/org" }
}

plug "eraserhd/parinfer-rust" do %{
	cargo install --force --path .
} config %{
	hook global WinSetOption filetype=(clojure|lisp|scheme|racket) %{
		parinfer-enable-window -indent
		auto-pairs-disable
	}
}

plug "occivink/kakoune-snippets"
plug "jjk96/kakoune-rainbow"

plug "notes" load-path "~/src/kak/kak-goal"

source "~/src/kak/kakoune-todo.txt/todotxt.kak"

plug "kak-lsp/kak-lsp" config %{
    # Language server protocol support.
    set-option global lsp_hover_anchor true
}


