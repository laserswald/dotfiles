
# try %{
#     remove-highlighter shared/lisp
# }

# # Highlighters
# # ‾‾‾‾‾‾‾‾‾‾‾‾

# add-highlighter shared/lisp regions
# add-highlighter shared/lisp/code default-region group
# add-highlighter shared/lisp/string  region '"' (?<!\\)(\\\\)*" fill string
# add-highlighter shared/lisp/comment region ';' '$'             fill comment

# # value type variable module function string keyword operator attribute comment meta builtin

# add-highlighter shared/lisp/code/ regex (#?(['`:]|,@?))\b[a-zA-Z][\w!$%&*+./:<=>?@^_~-]* 0:attribute
# add-highlighter shared/lisp/code/ regex \*[a-zA-Z][\w!$%&*+./:<=>?@^_~-]*\* 0:variable
# add-highlighter shared/lisp/code/ regex \+[a-zA-Z][\w!$%&*+./:<=>?@^_~-]*\+ 0:variable

# add-highlighter shared/lisp/code/ regex (((\Q***\E)|(///)|(\Q+++\E)){1,3})|(1[+-])|(<|>|<=|=|>=) 0:operator

# add-highlighter shared/lisp/code/ regex \b(defun|defclass|defmethod|defgeneric|defmacro|defconstant|defgeneric|defpackage|defparameter|defsetf|defstruct|deftype)\b 0:keyword
# add-highlighter shared/lisp/code/ regex \b(let|flet|labels|macrolet)\b 0:keyword
# add-highlighter shared/lisp/code/ regex \b(if|cond)\b 0:keyword
# add-highlighter shared/lisp/code/ regex \b(apply|funcall|lambda)\b 0:keyword

# add-highlighter shared/lisp/code/ regex \b(cons|consp|c[ad]+r|mapcar)\b 0:builtin

# add-highlighter shared/lisp/code/ regex \b(nil|t)\b 0:value
# add-highlighter shared/lisp/code/ regex (\b\d+)?\.\d+([eEsSfFdDlL]\d+)?\b 0:value

# add-highlighter shared/lisp/code/ regex 'defclass ([a-zA-Z-]+)' 1:type
# add-highlighter shared/lisp/code/ regex 'defun ([a-zA-Z-]+)' 1:function
# add-highlighter shared/lisp/code/ regex 'defmacro ([a-zA-Z-]+)' 1:meta

# # Commands
# # ‾‾‾‾‾‾‾‾

# define-command -override lisp-send-paragraph %{
#     execute-keys '<a-a>p'
#     send-text
# }

