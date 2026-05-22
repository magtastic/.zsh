# Modern replacements
alias cat='bat'
alias ls='eza'
alias ll='eza -lh --git'
alias la='eza -la --git'
alias lt='eza --tree --level=2'

# Shorthands
alias tf='terraform'
alias tmu='tmux attach || tmux new'

# Quick directory jumps
alias cddesk='cd ~/Desktop'
alias cddown='cd ~/Downloads'
alias cdconf='cd $CONFIG_PATH'
alias cddev='cd $DEVELOPER_PATH'
alias cdsmit='cd $SMITTEN_PATH'

# Copy local IP to clipboard, then echo it
alias cpip="ipconfig getifaddr en0 | tr -d '\n' | pbcopy | ipconfig getifaddr en0"

# 1Password fzf helpers
alias opid="op item list | fzf | cut -d ' ' -f1"
alias opitem="opid | xargs op item get"
alias opdocument="op document list | fzf | cut -d ' ' -f1 | xargs op document get"

# Get my iPhone device id from xctrace
alias my_phone_id="xcrun xctrace list devices | grep Magnús | awk 'NF>1{print \$NF}' | sed -r 's/^.*\(//' | sed -r 's/\)//'"

# fzf-driven git checkout (remote branches by recency, with log preview)
alias gico="git branch -r --sort=-committerdate --format='%(refname:short)' | fzf --preview 'git log --graph --color=always --abbrev-commit --decorate --format=format:\"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)\" {}' | sed 's/origin\///' | xargs git checkout"
