#
# Plugins.
#

# Initialize the plugin manager.
source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "robertmeta/plug.kak" noload

plug "kakounedotcom/prelude.kak"
plug "kakounedotcom/connect.kak"

plug "https://git.sr.ht/~raiguard/one.kak" theme

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

plug "andreyorst/powerline.kak" defer powerline %{
	powerline-format global 'git bufname filetype mode_info lsp line_column position client session'
} config %{
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

plug "occivink/kakoune-snippets" config %{
    set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
    set-option global snippets_auto_expand false
    map global normal <tab> ": snippets-select-next-placeholders<ret>"
}
plug "andreyorst/kakoune-snippet-collection"

plug "eraserhd/rep"

plug "crizan/kak-rainbower" config %{
	rainbower-compile
	set-option global rainbow_mode 0
}

plug "notes" load-path "~/src/kak/kak-goal"

# source "~/src/kak/kakoune-todo.txt/todotxt.kak"

plug "kak-lsp/kak-lsp" config %{
    # Language server protocol support.
    set-option global lsp_hover_anchor true
    set-option global lsp_hover_max_lines 10
}


