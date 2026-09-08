# 色の定義
autoload -Uz colors && colors

source ~/.zsh/rc/alias.zsh
source ~/.zsh/rc/path.zsh
source ~/.zsh/rc/prompt.zsh

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    autoload -Uz compinit
    compinit
fi

eval "$(/opt/homebrew/bin/brew shellenv zsh)"

eval "$(rbenv init - zsh)"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/ichiko-moro/.dart-cli-completion/zsh-config.zsh ]] && . /Users/ichiko-moro/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]
