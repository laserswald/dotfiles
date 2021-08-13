### Addons for Git buffers.

provide-module git-extras %{
    require-module git

    hook buffer WinSetOption filetype=git-status %{
	    map buffer normal <ret> ': git-status-go-to-file<ret>'
    }

    define-command -hidden git-status-go-to-file %{
        # Select the whole line.
        # Select the file only.
		# Invoke the "go to file" command
    }
}

