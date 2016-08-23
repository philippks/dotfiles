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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
