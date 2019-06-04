
provide-module ctags-fixes %{

define-command -override ctags-funcinfo -docstring "Display ctags information about a selected function" %{
    evaluate-commands -draft %{
        try %{
            execute-keys '[(;B<a-k>[a-zA-Z_]+\(<ret><a-;>'
            evaluate-commands %sh{
                sigs=$(readtags -e ${1} | grep kind:f | awk '
BEGIN {
    FS="\t";
}

{
    aggregate_name = "";
    identifier_name = $1;

    for (i=3; i<NF; i++) {
        split($i, colonfield, ":");
        if (colonfield[0] == "class" || colonfield[0] == "namespace" || colonfield[0] == "struct")
            aggregate_name = colonfield[1];
    }

    if (aggregate_name != "") {
	    printf "%s::", aggregate_name;
    } 
    printf "%s", identifier_name;
    printf "\n";
}
                ')

                if [ -n "$sigs" ]; then
                    printf %s\\n "evaluate-commands -client ${kak_client} %{info -anchor $kak_cursor_line.$kak_cursor_column -placement above '$sigs'}"
                fi
            }
        }
    }
}

}
