
# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

try %{
	remove-highlighter shared/php
	remove-highlighter shared/php-file
}

add-highlighter shared/php regions
add-highlighter shared/php/code  default-region group
add-highlighter shared/php/double_string region '"'    (?<!\\)(\\\\)*" group
add-highlighter shared/php/single_string region "'"    (?<!\\)(\\\\)*' fill string
add-highlighter shared/php/doc_comment   region ///    '$'             group
add-highlighter shared/php/doc_comment2  region /\*\*  \*/             ref php/doc_comment
add-highlighter shared/php/comment1      region //     '$'             fill comment
add-highlighter shared/php/comment2      region /\*    \*/             fill comment
add-highlighter shared/php/comment3      region '#'    '$'             fill comment



add-highlighter shared/php/code/ regex &?\$\w* 0:variable
add-highlighter shared/php/code/ regex \b(false|null|parent|self|true)\b 0:value
add-highlighter shared/php/code/ regex \$this 0:identifier
add-highlighter shared/php/code/ regex "(\b|-)[0-9]*\.?[0-9]+\b" 0:value
add-highlighter shared/php/code/ regex \b((string|int|bool|callable)|[A-Z][a-zA-Z_0-9].*?)\b 0:type
add-highlighter shared/php/code/ regex \B/[^\n/]+/[gimy]* 0:meta
add-highlighter shared/php/code/ regex '<\?(php)?|\?>' 0:meta
add-highlighter shared/php/code/ regex "function ([a-zA-Z_][a-zA-Z_0-9]*)\(" 1:function

add-highlighter shared/php/double_string/ fill string
add-highlighter shared/php/double_string/ regex (?<!\\)(\\\\)*(\$\w+)(->\w+)* 0:variable
add-highlighter shared/php/double_string/ regex \{(?<!\\)(\\\\)*(\$\w+)(->\w+)*\} 0:variable

# Highlight doc comment
add-highlighter shared/php/doc_comment/ fill block
add-highlighter shared/php/doc_comment/ regex '`.*`' 0:module
add-highlighter shared/php/doc_comment/ regex '@\w+' 0:meta

# Keywords are collected at
# http://php.net/manual/en/reserved.keywords.php
add-highlighter shared/php/code/ regex \b(__halt_compiler|and|array|as|break|case|catch|class|clone|continue|declare|default|die|do|echo|else|elseif|empty|enddeclare|endfor|endforeach|endif|endswitch|endwhile|eval|exit|extends|finally|for|foreach|function|global|goto|if|implements|include|include_once|instanceof|insteadof|interface|isset|list|namespace|new|or|print|require|require_once|return|switch|throw|trait|try|unset|use|var|while|xor|yield|__CLASS__|__DIR__|__FILE__|__FUNCTION__|__LINE__|__METHOD__|__NAMESPACE__|__TRAIT__)\b 0:keyword

add-highlighter shared/php/code/ regex \b(abstract|const|final|private|protected|public|static)\b 0:attribute

# Highlighter for html with php tags in it, i.e. the structure of conventional php files
add-highlighter shared/php-file regions
add-highlighter shared/php-file/html default-region ref html
add-highlighter shared/php-file/php-no-single  region (?<!')<\?(php)?     (?<!\\)\?>(?!')      ref php
add-highlighter shared/php-file/php-no-double  region (?<!")<\?(php)?     (?<!\\)\?>(?!")      ref php


