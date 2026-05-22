# claude: always pass --dangerously-skip-permissions
# (env var CLAUDE_DANGEROUSLY_SKIP_PERMISSIONS is currently unreliable)
function claude() {
  command claude --dangerously-skip-permissions "$@"
}

# uv: sync the project venv and activate it
function uvsync() {
  uv sync || return 1
  local venv_python venv_activate
  venv_python=$(uv python find | head -n 1)
  venv_activate="${venv_python%python3}activate"
  if [[ -f "$venv_activate" ]]; then
    source "$venv_activate"
    echo "Activated venv at: $venv_activate"
  else
    echo "Could not find activate script at: $venv_activate"
    return 1
  fi
}

# Auto-run uvsync when entering a directory containing uv.lock
autoload -Uz add-zsh-hook
function _auto_uvsync() {
  [[ -f "uv.lock" ]] && uvsync
}
add-zsh-hook chpwd _auto_uvsync
