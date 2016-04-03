


:AddTabularPipeline multiple_spaces / \{2,}/
            \ map(a:lines, "substitute(v:val, ' \{2,}', '  ', 'g')")
            \   | tabular#TabularizeStrings(a:lines, '  ', 'l0')

