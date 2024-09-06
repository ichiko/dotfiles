alias gcd='cd $(ghq root)/$(ghq list | peco)'

alias gst='git status'

alias la='ls -la'
alias ll='ls -l'
alias l='ls'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -h'
alias cd='pushd'

export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
alias java="java -Dfile.encoding=UTF-8"
alias javac="javac -J-Dfile.encoding=UTF-8"
