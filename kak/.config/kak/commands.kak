
define-command cqllog-hl %~
	addhl buffer/start regex '([a-zA-Z]+): evaluating...' 1:bright-magenta,default
	addhl buffer/return regex '([a-zA-Z]+) (-->) ([^{\n]+)' 1:magenta,default 2:yellow,default 3:green,default
	addhl buffer/returnexpr regex '\(\d+\) ([a-zA-Z0-9 ]+) (-->) ([^{\n]+)' 1:cyan,default 2:yellow,default 3:green,default
	addhl buffer/expressionref regex '\(\d+\) ([a-zA-Z0-9 ]+):' 1:bright-cyan,default
	addhl buffer/true regex 'TRUE' 0:green,default
	addhl buffer/false regex 'FALSE' 0:red,default
	addhl buffer/null regex 'NULL' 0:bright-red,default
~

## Commands.

define-command git-merge-left %{
	execute-keys "<a-/><<<<<<<?=======<a-x>d/>>>>>>>xd"
}

define-command git-merge-right %{
	execute-keys "<a-/><<<<<<<?=======<a-x>d/>>>>>>>xd"
}

define-command -params 1..1 rename-file %{
	nop %sh{
        mv "$kak_buffile" "$1"
    }
    delete-buffer!
    edit %arg{1}
}

define-command enable-lsp %{
    lsp-enable-window

    lsp-auto-hover-enable
    lsp-diagnostic-lines-enable window
    lsp-auto-signature-help-enable
}

