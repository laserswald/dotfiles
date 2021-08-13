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

map -docstring "Open a new note" \
	global user , \
	": zk-new-note<ret>"

# Go to mappings
map -docstring "your kakrc file" \
	global goto K \
	"<esc>: edit! ~/.config/kak/kakrc<ret>"

map -docstring "fuzzy finder" \
    global goto f \
    "<esc>: fzf-mode<ret>"

map -docstring "another open buffer" \
	global goto b \
	"<esc>: fzf-buffer<ret>"

map -docstring "symbol definition" \
	global goto d \
	"<esc><a-i>w: jump-to-definition<ret>"

map -docstring "next mention in buffer" \
	global goto n \
	"<esc><a-i>w*n<ret>"

map -docstring "goto reference for editing" \
	global goto u \
	"<esc>: find-references<ret>"

map -docstring "goto reference for viewing" \
	global goto x \
	"<esc>: cross-reference<ret>"

map -docstring "the scratch buffer" \
	global goto s \
    "<esc>: buffer *scratch*<ret>"

map -docstring "your notes index" \
	global goto s \
    "<esc>: edit! ~/org/index.md<ret>"
