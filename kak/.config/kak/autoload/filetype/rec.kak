
add-highlighter shared/rec regions
add-highlighter shared/rec/data default-region group
add-highlighter shared/rec/line-comment region     '^#'  '$'             fill comment

add-highlighter shared/rec/data/ regex '^(%[a-zA-Z0-9_]*:)[ \t]+([^\n]+)' 1:keyword 2:string
add-highlighter shared/rec/data/ regex '^[a-zA-Z][a-zA-Z0-9_]*:' 0:variable

hook global BufCreate .*[.]rec %{
  set-option buffer filetype rec
}

hook -group rec-highlight global WinSetOption filetype=rec %{ add-highlighter window/ ref rec }
hook -group rec-highlight global WinSetOption filetype=(?!rec).* %{ remove-highlighter window/rec }

#
define-command -params 0.. rec-query 
%{
	evaluate-commands %sh{
		tmp=$(tempfile "kak-rec.XXXXXX");
	    (
		    recsel $kak_bufname $@ >$tmp;
	    ) &
	    printf "edit! %s\n" $tmp
	}
}
