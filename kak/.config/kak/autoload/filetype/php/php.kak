
# Add the core type hints to the type regex
add-highlighter shared/php/code/ regex \b((string|int|bool|float|callable|iterable)|[A-Z][a-zA-Z].*?)\b 0:type
add-highlighter shared/php/code/ regex \b(\$this)\b 0:value


# Set dollar sign to the extra word characters
hook buffer WinSetOption filetype=php %{
	set buffer extra-word-chars "$"
}
