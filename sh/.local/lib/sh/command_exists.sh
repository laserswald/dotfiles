#!/bin/false
# vim:ft=sh
[ -n "$__LAZR_LIB_COMMAND_EXISTS_SH" ] && return || readonly __LAZR_LIB_COMMAND_EXISTS_SH=1

## command_exists COMMAND
##
## Returns 0 (success) if the command given can be called, otherwise returns non-zero on failure.
command_exists () {
    command -v "$1" 2>&1 >/dev/null
}
