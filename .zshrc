source .zsh/rc/alias.zsh
source .zsh/rc/path.zsh
source .zsh/rc/prompt.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(rbenv init - zsh)"
