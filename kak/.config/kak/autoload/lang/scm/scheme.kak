# http://www.scheme-reports.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# require lisp.kak

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate (.*/)?(.*\.(scm|ss|sld)) %{
    set-option buffer filetype scheme
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/ regions -default code scheme \
    string '"' (?<!\\)(\\\\)*"                    '' \
    comment ';' '$'                    '' \
    comment "#;\(" "\)" "\(" \
    comment "#\|" "\|#" "" \
    quote "'\(" "\)" "\(" \

add-highlighter shared/scheme/string  fill string
add-highlighter shared/scheme/comment fill comment
add-highlighter shared/scheme/quote fill variable

add-highlighter shared/scheme/code regex (#t|#f) 0:value
add-highlighter shared/scheme/code regex \b[0-9]+\b 0:value

%sh{
	# Primitive expressions.
	keywords="define do let let* letrec if cond case and or begin lambda delay delay-force set!"
	# Macro expressions
	meta="define-syntax let-syntax letrec-syntax syntax-rules syntax-case"
	operators="* + - ... / < <= = => > >="
	# Procedures that create a base type
	types="list vector bytevector cons string"
	# R5RS available procedures
	builtins=" abs acos angle append apply asin assoc assq assv atan boolean? caaaar
                caaadr caaar caadar caaddr caadr caar cadaar cadadr cadar
                caddar cadddr caddr cadr call-with-current-continuation
                call-with-input-file call-with-output-file call-with-values
                car cdaaar cdaadr cdaar cdadar cdaddr cdadr cdar cddaar
                cddadr cddar cdddar cddddr cdddr cddr cdr ceiling char->integer
                char-alphabetic? char-ci<=? char-ci<? char-ci=? char-ci>=? char-ci>?
                char-downcase char-lower-case? char-numeric? char-ready? char-upcase
                char-upper-case? char-whitespace? char<=? char<? char=? char>=?
                char>? char? close-input-port close-output-port complex?
                cons cos current-input-port current-output-port denominator
                display dynamic-wind else eof-object? eq? equal? eqv? eval
                even? exact->inexact exact? exp expt floor for-each force gcd
                imag-part inexact->exact inexact? input-port? integer->char
                integer? interaction-environment lcm length list list->string
                list->vector list-ref list-tail list? load log magnitude make-polar
                make-rectangular make-string make-vector map max member memq memv min
                modulo negative? newline not null-environment null? number->string
                number? numerator odd? open-input-file open-output-file or
                output-port? pair? peek-char positive? procedure? quasiquote quote
                quotient rational? rationalize read read-char real-part real? remainder
                reverse round scheme-report-environment set-car! set-cdr! sin
                sqrt string->list string->number string->symbol string-append
                string-ci<=? string-ci<? string-ci=? string-ci>=? string-ci>? string-copy
                string-fill! string-length string-ref string-set! string<=?
                string<? string=? string>=? string>? string? substring
                symbol->string symbol? syntax-rules tan truncate values
                vector vector->list vector-fill! vector-length vector-ref
                vector-set! vector? with-input-from-file with-output-to-file write
                write-char zero? "

    join () { printf "%s" "$1" | tr -s ' \n\t' "$2"; }

    printf '%s\n' "hook global WinSetOption filetype=scheme %{
        	set-option window static_words '$(join "$keywords:$meta:$operators:$builtins" ':' )'
    }"

    exact_quote () {
		for symbol in "$@"
		do
			printf '\\Q%s\\E ' "$symbol"
		done
    }

    qkeys=$(join "$(exact_quote $keywords)" '|')
    qmeta=$(join "$(exact_quote $meta)" '|')
    qops=$(join "$(exact_quote $operators)" '|')
    qbuiltins=$(join "$(exact_quote $builtins)" '|')
    qtypes=$(join "$(exact_quote $types)" '|')

	non_word_chars='[\s\(\)\[\]\{\}]'
	identifier_chars='[-!$%&\*\+\./:<=>\?\^_~a-zA-Z]'

    printf '%s\n' "add-highlighter shared/scheme/code regex ${non_word_chars}+(${qkeys})${non_word_chars} 1:keyword"
    printf '%s\n' "add-highlighter shared/scheme/code regex ${non_word_chars}+(${qmeta})${non_word_chars} 1:meta"
    printf '%s\n' "add-highlighter shared/scheme/code regex ${non_word_chars}+(${qops})${non_word_chars} 1:operator"
    printf '%s\n' "add-highlighter shared/scheme/code regex ${non_word_chars}+(${qbuiltins})${non_word_chars} 1:builtin"
    printf '%s\n' "add-highlighter shared/scheme/code regex ${non_word_chars}+('$identifier_chars+)${non_word_chars} 1:attribute"
    printf '%s\n' "add-highlighter shared/scheme/code regex ${non_word_chars}+($qtypes)${non_word_chars} 1:type"
    printf '%s\n' "add-highlighter shared/scheme/code regex \(define\W+\(($identifier_chars+) 1:function"

}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group scheme-highlight global WinSetOption filetype=scheme %{
    add-highlighter window ref scheme
    add-highlighter buffer show_matching
}

hook global WinSetOption filetype=scheme %{
	set-option buffer extra_word_chars %{-:!:%:?:<:>:=}
    hook window InsertEnd  .* -group scheme-hooks  lisp-filter-around-selections
    hook window InsertChar \n -group scheme-indent lisp-indent-on-new-line
}

hook -group scheme-highlight global WinSetOption filetype=(?!scheme).* %{ remove-highlighter window/scheme }

hook global WinSetOption filetype=(?!scheme).* %{
    remove-hooks window scheme-indent
    remove-hooks window scheme-hooks
}
