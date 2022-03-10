# Mappings

# User mappings
map -docstring "Comment the selection, block style" \
	global user C \
	": comment-block<ret>"

map -docstring "Comment the selection" \
	global user c \
	": comment-line<ret>"

map -docstring "Delete this buffer." \
	global user d \
	": delete-buffer<ret>"

map -docstring "Make the current project" \
	global user m \
	": make<ret>"

map -docstring "Load your kakrc" \
	global user R \
	": source ~/.config/kak/kakrc<ret>"

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

#
# Go to mappings
# 
map -docstring "your kakrc file" \
	global goto K \
	"<esc>: edit! ~/.config/kak/kakrc<ret>"

map -docstring "fuzzy finder" \
    global goto f \
    "<esc>: require-module fzf-file; fzf-file<ret>"

map -docstring "another open buffer" \
	global goto b \
	"<esc>: require-module fzf-buffer; fzf-buffer<ret>"

map -docstring "symbol definition" \
	global goto d \
	"<esc>: goto-definition<ret>"

map -docstring "goto reference for editing" \
	global goto r \
	"<esc>: find-references<ret>"

map -docstring "the scratch buffer" \
	global goto s \
    "<esc>: buffer *scratch*<ret>"

