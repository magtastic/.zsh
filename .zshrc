# ────────────────────────────────────────────────────────────────────────────
# Powerlevel10k instant prompt — must run before any output-producing init.
# ────────────────────────────────────────────────────────────────────────────
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ────────────────────────────────────────────────────────────────────────────
# Plugins — antidote loads everything in .zsh_plugins.txt
# ────────────────────────────────────────────────────────────────────────────
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# ────────────────────────────────────────────────────────────────────────────
# Prompt — Powerlevel10k (brew install). Run `p10k configure` to (re)generate
# .p10k.zsh.  The element lists below override anything in .p10k.zsh.
# ────────────────────────────────────────────────────────────────────────────
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -r $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  python
  aws
  command_execution_time
  status
  context
  time
)

# ────────────────────────────────────────────────────────────────────────────
# Runtimes & shell hooks
# ────────────────────────────────────────────────────────────────────────────
# mise — node/python/java/ruby/etc. version manager (replaces nvm)
eval "$(/opt/homebrew/bin/mise activate zsh)"

# direnv — per-directory env files
eval "$(direnv hook zsh)"

# fzf shell integration (Ctrl-T file picker, Alt-C cd) and atuin (Ctrl-R history).
# --disable-up-arrow keeps Up = zsh's standard previous-command-recall (editable
# inline). Atuin's full TUI search stays on Ctrl-R.
# Re-init inside zsh-vi-mode hook so its keybindings don't get clobbered.
zvm_after_init_commands+=(
  'source <(fzf --zsh)'
  'eval "$(atuin init zsh --disable-up-arrow)"'
)

# ────────────────────────────────────────────────────────────────────────────
# Personal config
# ────────────────────────────────────────────────────────────────────────────
[[ -r $ZDOTDIR/aliases.zsh   ]] && source $ZDOTDIR/aliases.zsh
[[ -r $ZDOTDIR/functions.zsh ]] && source $ZDOTDIR/functions.zsh
[[ -r $ZDOTDIR/smitten.zsh   ]] && source $ZDOTDIR/smitten.zsh

# Bun completions
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# Local-only overrides (untracked, machine-specific)
[[ -r $ZDOTDIR/local.zsh ]] && source $ZDOTDIR/local.zsh

. "$HOME/.local/share/../bin/env"
