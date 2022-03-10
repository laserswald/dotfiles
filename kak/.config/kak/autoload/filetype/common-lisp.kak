# # http://common-common-lisp.net
# # ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](lisp|asd|lsp) %{
  set-option buffer filetype common-lisp
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=common-lisp %{
    require-module lisp

    hook window ModeChange pop:insert:.* -group lisp-trim-indent  lisp-trim-indent
    hook window InsertChar \n -group lisp-indent lisp-indent-on-new-line
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window lisp-.+ }

    require-module common-lisp
    set-option buffer extra_word_chars '_' '+' '-' '*' '/' '@' '$' '%' '^' '&' '_' '=' '<' '>' '~' '.'
}

hook -group common-lisp-highlight global WinSetOption filetype=common-lisp %{
    add-highlighter window/common-lisp ref common-lisp
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/common-lisp }
}

provide-module common-lisp %{

remove-highlighter shared/common-lisp

add-highlighter shared/common-lisp regions
add-highlighter shared/common-lisp/code default-region group
add-highlighter shared/common-lisp/string  region '"' (?<!\\)(\\\\)*" fill string
add-highlighter shared/common-lisp/comment region ';' '$'             fill comment

evaluate-commands %sh{ exec awk -f - <<'EOF'
    BEGIN {
        # Destructuring form stuff
        split("&allow-other-keys &aux &body &environment &key &optional &rest &whole", attributes)

        # Global variables
		split("*break-on-signals* *compile-file-pathname* *compile-file-truename* "\
			  "*compile-print* *compile-verbose* *debug-io* *debugger-hook* "\
			  "*default-pathname-defaults* *error-output* *features* *gensym-counter* "\
			  "*load-pathname* *load-print* *load-truename* *load-verbose* "\
			  "*macroexpand-hook* *modules* *package* *print-array* *print-base* "\
			  "*print-case* *print-circle* *print-escape* *print-gensym* *print-length* "\
			  "*print-level* *print-lines* *print-miser-width* *print-pprint-dispatch* "\
			  "*print-pretty* *print-radix* *print-readably* *print-right-margin* "\
			  "*query-io* *random-state* *read-base* *read-default-float-format* "\
			  "*read-eval* *read-suppress* *readtable* *standard-input* *standard-output* "\
			  "*terminal-io* *trace-output* ", global_variables);

	    # Flow control
        split("abort and block break call-method call-next-method case catch "\
              "ccase cond ctypecase destructuring-bind do do* do-all-symbols "\
              "do-external-symbols do-symbols dolist dotimes ecase error eval-when flet "\
              "funcall go handler-bind handler-case if ignore-errors invoke-debugger "\
              "invoke-restart invoke-restart-interactively labels let let* loop macrolet "\
              "multiple-value-bind multiple-value-call multiple-value-prog1 prog prog* "\
              "prog1 prog2 progn progv restart restart-bind restart-case restart-name "\
              "return return-from setf setq tagbody typecase unless values when "\
              "with-accessors with-compilation-unit with-condition-restarts "\
              "with-hash-table-iterator with-input-from-string with-open-file "\
              "with-open-stream with-output-to-string with-package-iterator "\
              "with-simple-restart with-slots with-standard-io-syntax ", flow_control);

	    # Definitions
        split("defclass defconstant defgeneric define-condition define-method-combination "\
			  "define-setf-expander defmethod defpackage defparameter defsetf defstruct "\
			  "deftype defun defvar ", definitions);

        # Macro definitions
        split("define-compiler-macro define-method-combination define-modify-macro "\
              "define-setf-expander define-symbol-macro defmacro", meta);

        # Basic operators.
        split("+ ++ +++ - / // /// /= 1+ 1- < <= = > >=", operators);

        # Procedures that create a base type and their predicates (for easier type checking)
        split("list vector cons hash-table char booleanp listp consp floatp hash-table-p constantp vectorp arrayp bit-vector-p "\
              "stringp characterp complexp end-of-file endp input-stream-p integerp null numberp "\
              "output-portp portp functionp compiled-function-p symbolp", types);

        # R7RS available procedures
        split("abs acos angle append apply asin assoc assq assv atan "\
              "caaaar caaadr caaar caadar caaddr caadr "\
              "caar cadaar cadadr cadar caddar cadddr caddr cadr "\
              "call-with-values car cdaaar cdaadr cdaar cdadar cdaddr "\
              "cdadr cdar cddaar cddadr cddar cdddar cddddr cdddr cddr cdr ceiling "\
              "char-code char-code-limit char-downcase char-equal char-greaterp char-int "\
              "char-lessp char-name char-not-equal char-not-greaterp char-not-lessp "\
              "char-upcase char/= char< char<= char= char> char>= "\
              "cos "\
              "current-input-port current-output-port denominator digit-value display "\
              "dynamic-wind eq? equal? eqv? error error-object-irritants "\
              "error-object-message error-object? eval even? exact exact->inexact "\
              "exact-integer? exact-integer-sqrt exact? exp expt features file-error? "\
              "finite? floor floor/ floor-quotient floor-remainder for-each force "\
              "flush-output-port gcd get-output-bytevector get-output-string guard imag-part "\
              "inexact->exact inexact inexact? infinite? input-port-open? integer->char "\
              "integer? interaction-environment lcm length list list-copy list-set! "\
              "list->string list->vector list-ref list-tail load log magnitude "\
              "make-bytevector make-list make-parameter make-polar make-promise "\
              "make-rectangular make-string make-vector map max member memq memv min modulo "\
              "nan? negative? newline not null-environment number->string numerator odd? "\
              "open-input-bytevector open-input-file open-input-string "\
              "open-output-bytevector open-output-file open-output-string output-port-open? "\
              "or parameterize peek-char peek-u8 positive? promise? quotient raise "\
              "raise-continuable rational? rationalize read read-bytevector read-bytevector! "\
              "read-char read-error? read-line read-string read-u8 real-part real? remainder "\
              "reverse round scheme-report-environment set-car! set-cdr! sin square sqrt "\
              "string->list string->number string->symbol string->utf8 string->vector "\
              "string-append string-ci<=? string-ci<? string-ci=? string-ci>=? string-ci>? "\
              "string-copy string-copy! string-downcase string-fill! string-foldcase "\
              "string-for-each string-length string-map string-ref string-set! string-upcase "\
              "string<=? string<? string=? string>=? string>? substring symbol=? "\
              "symbol->string syntax-error tan textual-port? truncate truncate/ "\
              "truncate-quotient truncate-remainder u8-ready? unless utf8->string values "\
              "vector vector->list vector->string vector-append vector-copy vector-copy! "\
              "vector-for-each vector-fill! vector-length vector-map vector-ref vector-set! "\
              "when with-exception-handler with-input-from-file with-output-to-file write "\
              "write-bytevector write-char write-string write-u8 zero?", builtins);

        non_word_chars="['\"\\s\\(\\)\\[\\]\\{\\};]";

        normal_identifiers="-!$%&\\*\\+\\./:<=>\\?@\\^_~a-zA-Z0-9";
        identifier_chars="[" normal_identifiers "][" normal_identifiers ",#]*";
    }
    function kak_escape(s) {
        gsub(/'/, "''", s);
        return "'" s "'";
    }
    function add_highlighter(regex, highlight) {
        printf("add-highlighter shared/common_lisp/code/ regex %s %s\n", kak_escape(regex), highlight);
    }
    function quoted_join(words, quoted, first) {
        first=1
        for (i in words) {
            if (!first) { quoted=quoted "|"; }
            quoted=quoted "\\Q" words[i] "\\E";
            first=0;
        }
        return quoted;
    }
    function add_word_highlighter(words, face, regex) {
        regex = "(?<![" normal_identifiers "])(" quoted_join(words) ")(?![" normal_identifiers "])";
        add_highlighter(regex, "1:" face);
    }
    function print_words(words) {
        for (i in words) { printf(" %s", words[i]); }
    }

    BEGIN {
        printf("declare-option str-list common-lisp_static_words ");
        print_words(global_variables);
        print_words(flow_control);
        print_words(definitions);
        print_words(meta);
        print_words(operators);
        print_words(builtins);
        print_words(attributes);
        printf("\n");

        add_word_highlighter(global_variables, "value");
        add_word_highlighter(flow_control, "keyword");
        add_word_highlighter(definitions, "keyword");
        add_word_highlighter(meta, "meta");
        add_word_highlighter(operators, "operator");
        add_word_highlighter(builtins, "function");
        add_word_highlighter(types, "type");
        add_word_highlighter(attributes, "attribute");

        add_highlighter(non_word_chars "+('" identifier_chars ")", "1:attribute");
        add_highlighter("\\(defun\\W+(" identifier_chars ")\\W+\\(", "1:function");

        # unprefixed decimals
        add_highlighter("(?<![" normal_identifiers "])(\\d+(\\.\\d*)?|\\.\\d+)(?:[esfdlESFDL][-+]?\\d+)?(?![" normal_identifiers "])", "0:value");
        # inf and nan
        add_highlighter("(?<![" normal_identifiers "])[+-](?:inf|nan)\.0(?![" normal_identifiers "])", "0:value");
    }
EOF
}


# add-highlighter shared/common-lisp/code/ regex (#?(['`:]|,@?))?\b[a-zA-Z][\w!$%&*+./:<=>?@^_~-]* 0:variable
# add-highlighter shared/common-lisp/code/ regex \*[a-zA-Z][\w!$%&*+./:<=>?@^_~-]*\* 0:variable
add-highlighter shared/common-lisp/code/keywords regex \b[:][a-zA-Z][\w!$%&*+./:<=>?@^_~-]*\b 0:variable
add-highlighter shared/common-lisp/code/special-symbols regex \b(nil|t)\b 0:value
add-highlighter shared/common-lisp/code/ regex (((\Q***\E)|(///)|(\Q+++\E)){1,3})|(1[+-])|(<|>|<=|=|>=) 0:operator
add-highlighter shared/common-lisp/code/numbers regex (\b\d+)?\.\d+([eEsSfFdDlL]\d+)?\b 0:value

}
