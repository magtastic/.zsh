#  ~~~~~~~~~~~~~~~~
# * Instant Prompt *
#  ~~~~~~~~~~~~~~~~
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# I need to suppress the the warning because of prints when starting shell with direnv
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

#  ~~~~~~~
# * Alias *
#  ~~~~~~~
alias tf="terraform"
alias tmu="tmux attach || tmux new"
alias cat="bat"
alias gico="git branch -r --sort=-committerdate --format='%(refname:short)' | fzf --preview 'git log --graph --color=always --abbrev-commit --decorate --format=format:\"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)\" {}' | sed 's/origin\///' | xargs git checkout"
alias opid="op item list | fzf | cut -d ' ' -f1"
alias opitem="opid | xargs op item get"
alias opdocument="op document list | fzf | cut -d ' ' -f1 | xargs op document get"
alias myPhoneId="xcrun xctrace list devices | grep Magnús | awk 'NF>1{print $NF}' | sed -r 's/^.*\(//' | sed -r 's/\)//'"


alias cddesk="cd ~/Desktop"
alias cddown="cd ~/Downloads"
alias cdconf="cd $CONFIG_PATH"
alias cddev="cd $DEVELOPER_PATH"
alias cdsmit="cd $SMITTEN_PATH"

alias cpip="ipconfig getifaddr en0 | tr -d '\n' | pbcopy | ipconfig getifaddr en0"

alias smitten_docker_id="docker ps -aqf \"name=^api-api\""
alias smitten_dd_agent_docker_id="docker ps -aqf \"name=^api-dd_agent\""
alias smitten_stoken="run_sql_query \"select token from session_token inner join user_account on user_account.id = session_token.user_id where email = 'magnusol93@gmail.com' limit 1;\" |  rg '\S'"
alias smitten_uuid="run_sql_query \"select uuid_ from user_account where email = 'magnusol93@gmail.com' order by created_at desc limit 1;\" |  rg '\S' | xargs"
alias smit_random_token="run_sql_query \"select token from session_token inner join user_account on user_account.id = session_token.user_id where ( email != 'magnusol93@gmail.com' or email is null ) order by RANDOM() limit 1;\" |  rg '\S'"
alias smit_random_uuid="run_sql_query \"select uuid_ from user_account where email != 'magnusol93@gmail.com' or email is null order by RANDOM() limit 1;\" |  rg '\S' | xargs"

#  ~~~~~~~~~~~
# * Functions *
#  ~~~~~~~~~~~
smitten(){
  if [ -z "$1" ]
  then
     aws sso login --profile smitten
     export AWS_PROFILE=smitten
     $(aws-export-credentials --profile smitten --env-export)
  else
     aws sso login --profile smitten-$1
     export AWS_PROFILE=smitten-$1
     $(aws-export-credentials --profile smitten-$1 --env-export)
  fi
}

aws_instanceid() {
   aws ec2 describe-instances |
   jq '.Reservations | .[].Instances | .[].InstanceId' |
   sed 's/"//g'
}

aws_instanceid_new() {
   aws ec2 describe-instances |
   jq '.Reservations | .[].Instances' | fzf
}

psqlv() {
  PGPASSWORD=smitten pgcli -h localhost -p 2345 -u smitten
}

run_sql_query() {
  PGPASSWORD=smitten psql -h localhost -p 2345 -U smitten -t -c $1
}

copy_smitten_table() {
  run_sql_query "\copy $1 to '$(pwd)/$1.csv' CSV"
}


#  ~~~~
# * UI *
#  ~~~~
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir 
  vcs 
  newline 
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  aws 
  command_execution_time
  status
  nvm
  pyenv
  context
)


#  ~~~~
# * UX *
#  ~~~~
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# TODO FIX:  chpwd:1: bad floating point constant
# AUTOMATICALLY_SOURCED_FILES=(".awsrc" ".bash_functions" ".customrc")
#
# function chpwd {
#   for i in "${AUTOMATICALLY_SOURCED_FILES[@]}"
#   do
#     if test -f "$(pwd)/$i"; then
#       source $(pwd)/$i
#       echo "[Sourced ⚡️] Found $i in directory."
#     fi
#   done
# }

#  ~~~~~~~~~
# * Plugins *
#  ~~~~~~~~~
plugins=(
  poetry
  git
  macos
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vi-mode
)

#  ~~~~~~~
# * PyEnv *
#  ~~~~~~~
export PYENV_ROOT="$CONFIG_PATH/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


#  ~~~~~~~~~~~~
# * 1 Password *
#  ~~~~~~~~~~~~
# eval "$(op completion zsh)"; compdef _op op


#  ~~~~~~~~~~~
# * Home Brew *
#  ~~~~~~~~~~~
eval "$(/opt/homebrew/bin/brew shellenv)"


#  ~~~~~~~~~~~~~~~~~~~~~~
# * Node Version Manager *
#  ~~~~~~~~~~~~~~~~~~~~~~
export NVM_DIR="$CONFIG_PATH/zsh/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#  ~~~~~~~~
# * Direnv *
#  ~~~~~~~~
eval "$(direnv hook zsh)"


#  ~~~~~~~
# * McFly *
#  ~~~~~~~
eval "$(mcfly init zsh)"

#  ~~~~~~~~~~~
# * Oh My Zsh *
#  ~~~~~~~~~~~
source $ZSH/oh-my-zsh.sh

#  ~~~~~~~~~~~~~~~~~~~~~~
# * Ruby Version Manager*
#  ~~~~~~~~~~~~~~~~~~~~~~
source $HOME/.rvm/scripts/rvm
