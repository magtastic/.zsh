# Smitten — work-specific helpers.

# AWS SSO login + export creds.
# Default profile = "smitten"; pass arg "<env>" for "smitten-<env>".
function smitten() {
  local profile="smitten"
  [[ -n "$1" ]] && profile="smitten-$1"
  aws sso login --profile "$profile"
  export AWS_PROFILE="$profile"
  $(aws configure export-credentials --profile "$profile" --format env)
}

# Local Smitten Postgres (dev DB on :2345)
#   psqlv → pgcli (autocomplete + syntax highlighting). Kept the old name
#           for muscle memory; behavior is now pgcli, not plain psql.
function psqlv() {
  PGPASSWORD=smitten pgcli -h localhost -p 2345 -U smitten "$@"
}

function run_sql_query() {
  PGPASSWORD=smitten psql -h localhost -p 2345 -U smitten -t -c "$1"
}

function copy_smitten_table() {
  run_sql_query "\copy $1 to '$(pwd)/$1.csv' CSV"
}

# Token + uuid lookups
alias smitten_stoken="run_sql_query \"select token from session_token inner join user_account on user_account.id = session_token.user_id where email = 'magnusol93@gmail.com' limit 1;\" | rg '\S'"
alias smitten_uuid="run_sql_query \"select uuid_ from user_account where email = 'magnusol93@gmail.com' order by created_at desc limit 1;\" | rg '\S' | xargs"
alias smit_random_token="run_sql_query \"select token from session_token inner join user_account on user_account.id = session_token.user_id where ( email != 'magnusol93@gmail.com' or email is null ) order by RANDOM() limit 1;\" | rg '\S'"
alias smit_random_uuid="run_sql_query \"select uuid_ from user_account where email != 'magnusol93@gmail.com' or email is null order by RANDOM() limit 1;\" | rg '\S' | xargs"

# Docker
alias smitten_api_docker_id='docker ps -qf "name=^backend-api"'
alias smitten_dd_agent_docker_id='docker ps -aqf "name=^api-dd_agent"'
