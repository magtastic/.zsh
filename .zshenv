
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export ZDOTDIR="$HOME/.config/zsh"

export ANDROID_HOME="$HOME/Library/Android/sdk"
#  ~~~~~~
# * PATH *
#  ~~~~~~
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

#  ~~~~~~~~~~~
# * Variables *
#  ~~~~~~~~~~~
# Personal variables
export CONFIG_PATH="$HOME/.config"
export DEVELOPER_PATH="$HOME/Developer"
export SMITTEN_PATH="$DEVELOPER_PATH/Smitten/smitten"

#  Package specific variables
export ZSH="$ZDOTDIR/.oh-my-zsh"
export LUA_PATH="$CONFIG_PATH/nvim/?.lua;;"
export LESSHISTFILE=-
export TF_CLI_CONFIG_FILE="$CONFIG_PATH/terraform/.terraformrc"
export RUSTUP_HOME="$CONFIG_PATH/rust/.rustup"
export CARGO_HOME="$CONFIG_PATH/rust/.cargo"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

#  OS variables
if [[ -n $SSH_CONNECTION ]]; then
 export EDITOR='vim'
else
 export EDITOR='nvim'
fi

source "$CARGO_HOME/env"

