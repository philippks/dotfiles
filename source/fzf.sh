export FZF_DEFAULT_COMMAND='ag --hidden --ignore-case --ignore .git -g ""'
export FZF_DEFAULT_OPTS="--tiebreak=length,begin"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source ~/.fzf/shell/key-bindings.bash
source ~/.fzf/shell/completion.bash
