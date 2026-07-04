#!/bin/bash

pane_tty=$(tmux display-message -p '#{pane_tty}')

# Get SSH command from this pane
ssh_cmd=$(ps -t "${pane_tty##/dev/}" -o args= 2>/dev/null | grep -E '^ssh ' | grep -v ControlMaster | head -n1)

if [ -n "$ssh_cmd" ]; then
    # Extract hostname/user@hostname (the last argument that doesn't start with -)
    # This handles: ssh host, ssh user@host, ssh -p 2220 user@host, etc.
    target=$(echo "$ssh_cmd" | awk '{
        for(i=NF; i>=2; i--) {
            # Skip if it starts with - (option)
            if ($i !~ /^-/) {
                # Check if previous arg was an option that takes a value (-p, -i, etc)
                if (i > 1 && $(i-1) ~ /^-(p|i|l|o|F|S|c|D|e|E|I|L|m|O|R|W)$/) {
                    continue
                }
                print $i
                exit
            }
        }
    }')
    
    if [ -n "$target" ]; then
        # If no @ in target, add user@
        if [[ "$target" != *@* ]]; then
            echo "  $(whoami)@${target}"
        else
            echo "  ${target}"
        fi
    fi
fi
