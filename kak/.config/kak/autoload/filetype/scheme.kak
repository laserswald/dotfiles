### Lazr's Scheme stuff

hook -once global WinSetOption filetype=scheme %{
	evaluate-commands %sh{
		identifier_chars='-!$%&\\*\\+\\./:<=>\\?\\^_~a-zA-Z0-9'
		identifier='(['$identifier_chars']+)'
		constructor='(?:\('$identifier'.*\)|#f)'
		predicate='(?:(['$identifier_chars']+\?)|#f)'
		regex='\(define-record-type\s+'$identifier'\s+'$constructor'\s+'$predicate
		highlights="1:type 2:function 3:function"
		printf "add-highlighter shared/scheme/code/define-record-type regex '%s' %s\n" "$regex" "$highlights"
		printf "add-highlighter shared/scheme/code/ regex define-record-type 0:keyword\n"
	}
}

