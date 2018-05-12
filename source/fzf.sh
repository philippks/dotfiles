export FZF_DEFAULT_COMMAND='ag --ignore *.pyc -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# directly execute selected item from history search
bind "$(bind -s | grep '^"\\C-r"' | grep -v '\\C-m' | sed 's/"$/\\C-m"/')"
