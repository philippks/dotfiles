# Nur laden, wenn interaktive Session
[ -z "$PS1" ] && return

# Where the magic happens.
export DOTFILES=~/.dotfiles

# source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

src

set -o vi
alias vi='vim'
export EDITOR='vim'
eval "$(direnv hook bash)"
eval "$(rbenv init -)"
. /usr/share/autojump/autojump.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
