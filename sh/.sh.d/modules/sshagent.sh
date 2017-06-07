#!/bin/sh
# Start up an SSH agent so I don't have to write the keys all the time

if ! pgrep -u $USER ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval $(<~/.ssh-agent-thing)
fi

EXTRA_KEYS="~/.ssh/ahi_rs"

ssh_add_extras() {
    echo "Adding extra SSH keys to your keyring..."
    for f in $EXTRA_KEYS
    do
        [ -f "$f" ] && ssh-add "$f"
    done
}

ssh_setup_keys() {
    if ! ssh-add -l >/dev/null; then
        ssh-add
        ssh_add_extras
    fi
}

if ! ssh-add -l >/dev/null; then
    alias ssh='ssh_setup_keys && unalias ssh;ssh'
fi

