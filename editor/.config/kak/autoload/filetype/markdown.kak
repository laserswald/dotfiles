
hook global WinSetOption filetype=markdown %{
	require-module markdown-extras

}

provide-module markdown-extras %{
require-module markdown

# Have to remove code block so our custom guys can override it
remove-highlighter shared/markdown/codeblock

# Shotgun surgery if I've ever seen it
evaluate-commands %sh{
  languages="scheme todotxt"
  for lang in ${languages}; do
	printf 'add-highlighter shared/markdown/%s region -match-capture ^(\h*)```\h*%s\\b   ^(\h*)``` regions\n' "${lang}" "${lang}"
    printf 'add-highlighter shared/markdown/%s/ default-region fill meta\n' "${lang}"
    [ "${lang}" = kak ] && ref=kakrc || ref="${lang}"
    printf 'add-highlighter shared/markdown/%s/inner region \A```[^\\n]*\K (?=```) ref %s\n' "${lang}" "${ref}"
  done
}

add-highlighter shared/markdown/codeblock region -match-capture \
    ^(\h*)```\h* \
    ^(\h*)```\h*$ \
    fill meta
}
