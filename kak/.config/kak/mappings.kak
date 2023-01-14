# Mappings
# User mappings

map -docstring "file in project" \
    global user f \
    "<esc>: require-module fzf-file; fzf-file<ret>"

# Execute
try %{
    declare-user-mode execute
}

map -docstring "Execute selection" \
    global execute . \
    ": echo 'Execute selection not supported for this filetype'"

map -docstring "Execute file" \
    global execute f \
    ": echo 'Execute file not supported for this filetype'"

map -docstring "Evaluate selection in the REPL." \
    global user e \
    ": repl-send-text<ret>"

map -docstring "Build the project" \
    global execute p \
    ": make<ret>"

map -docstring "Enter execute mode" \
    global user x \
    ": enter-user-mode execute<ret>"

# Editing tools

map -docstring "Comment the selection, block style" \
	global user C \
	": comment-block<ret>"

map -docstring "Comment the selection" \
	global user c \
	": comment-line<ret>"

map -docstring "Delete this buffer." \
    global user d \
    ": delete-buffer<ret>"


# Settings

map -docstring "Load your kakrc" \
    global user R \
    ": source ~/.config/kak/kakrc<ret>"

map -docstring "your kakrc file" \
    global user K \
    "<esc>: edit! ~/.config/kak/kakrc<ret>"


map -docstring "Write the file and add the changes to version control" \
    global user w \
    ": write<ret>: git add<ret>"

map -docstring "Manage splits" \
    global user S \
    ": enter-user-mode splits<ret>"

map -docstring "Open fuzzy finder mode" \
    global user , \
    ": fzf-mode<ret>"

map -docstring "Paste from system clipboard" \
    global user p \
    "<a-!> xclip -o -selection clipboard<ret>"

map -docstring "Paste before" \
    global user P \
    "! xclip -o -selection clipboard<ret>"

map -docstring "Choose left side of merge block" \
    global user h \
    ": git-merge-left<ret>"

map -docstring "Choose right side of merge block" \
    global user l \
    ": git-merge-right<ret>"

map -docstring "Git mode" \
    global user g \
    ": enter-user-mode git<ret>"

map -docstring "LSP menu" \
    global user <space> \
    ": enter-user-mode lsp<ret>"

#
# Go to mappings
# 

map -docstring "another open buffer" \
    global goto b \
    "<esc>: require-module fzf-buffer; fzf-buffer<ret>"

map -docstring "symbol definition" \
    global goto d \
    "<esc>: goto-definition<ret>"

map -docstring "symbol documentation" \
    global goto <a-d> \
    "<esc>: zeal-search<ret>"

map -docstring "goto reference for editing" \
    global goto r \
    "<esc>: find-references<ret>"

map -docstring "the scratch buffer" \
    global goto s \
    "<esc>: buffer *scratch*<ret>"

