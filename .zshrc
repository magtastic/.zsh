#  ~~~~~~~~~~~~~~~~
# * Instant Prompt *
#  ~~~~~~~~~~~~~~~~
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# I need to suppress the the warning because of prints when starting shell with direnv
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

source $CONFIG_PATH/zsh/.zsh_alias
source $CONFIG_PATH/zsh/.zsh_functions

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
  context
  time
  date
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
  fzf-tab
  nvm
  git
  macos
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vi-mode
  autoupdate
)

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

# Hate this. I need to find a better way to do this
export PATH="$PATH:$(python3.11 -m site --user-base)/bin"

# flashlight
export PATH="/Users/magtastic/.flashlight/bin:$PATH"
export PATH=$PATH:$HOME/.maestro/bin

# bun completions
[ -s "/Users/magtastic/.bun/_bun" ] && source "/Users/magtastic/.bun/_bun"


# Bun stuff
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/magtastic/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
