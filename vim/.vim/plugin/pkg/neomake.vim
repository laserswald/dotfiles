
if exists('g:loaded_neomake')
    call neomake#configure#automake('w')

    function! PhpUnitProcessOutput(context)
        let entries = []
        let current_entry = {}
        let num_entries = 0

        let entry_ready = 0
        let entry_started = 0

        for line in a:context.output
            " Blank line
            if line =~# '^$'
                if entry_ready ==# 1
                    let entries[len(entries)-1] = current_entry
                    let current_entry = {}
                    let entry_ready = 0
                    let entry_started = 0
                    let num_entries += 1
                endif
                " Test failure
            elseif line =~# '[0-9]\+) .*'
                let current_entry.nr = str2nr( substitute(line, ') .*', '', '') )
                let current_entry.text = substitute(line, '^[0-9]\+) ', '', '')
                let entry_started = 1
                " file and line
            elseif line =~# '^.*:[0-9]\+$'
                let current_entry.filename = substitute(line, ':[0-9]\+$', '', '')
                let current_entry.lnum = str2nr( substitute(line, '^.*:', '', '') )

                let trace_entry = {}
                call extend(trace_entry, current_entry)
                let trace_entry.type = 'I'
                let trace_entry.text = ''
                call add(entries, trace_entry)

                let entry_ready = 1
            else
                if entry_started ==# 1
                    let current_entry.text .= '\n'.line
                endif
            endif

        endfor
        return entries
    endfunction

    let g:neomake_phpunit_maker = {
                \ 'exe': 'phpunit',
                \ 'process_output': function("PhpUnitProcessOutput"),
                \ }

    let g:neomake_php_phpunit_maker = {
                \ 'exe': 'phpunit',
                \ 'process_output': function("PhpUnitProcessOutput"),
                \ }
endif
