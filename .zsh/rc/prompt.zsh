# 色の定義
autoload -Uz colors && colors

function prompt_command_result() {
  local prompt_color="${ICK_RESULT_COLOR:-$prompt_ick_default_result_color}"
  local prompt_color_error="${ICK_RESULT_COLOR_ERROR:-$prompt_ick_default_result_color_error}"
  echo "%F{%(?.${prompt_color}.${prompt_color_error})}[%?]%f"
}

function user_with_host() {
  local prompt_color="${ICK_USER_COLOR:-$prompt_ick_default_user_color}"
  if [[ -n "$SSH_CONNECTION" ]]; then
    echo -n "%F{${prompt_color}}%n@%m%f"
  else
    echo -n "%F{${prompt_color}}%n%f"
  fi
}

function prompt_dir() {
  local prompt_color="${ICK_DIR_COLOR:-$prompt_ick_default_dir_color}"
  if (( dir_components )); then
    echo -n "%F{${prompt_color}}%($((dir_components + 1))~:...%${dir_components}~:%~)%f"
  else
    echo -n "%F{${prompt_color}}%~%f"
  fi
}

# git情報を取得する関数
function git_prompt_info() {
  local prompt_color="${ICK_GIT_COLOR:-$prompt_ick_default_git_color}"
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  local branch=${ref#refs/heads/}
  local git_status=$(command git status --porcelain 2> /dev/null)
  

  if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = true ]; then
    echo " %F{${prompt_color}}${branch}*%f"
  elif [[ -n "$git_status" ]]; then
    echo " %F{${prompt_color}}${branch}*%f"
  else
    echo "%F{${prompt_color}}${branch}%f"
  fi
}

prompt_ick_setup() {
  # Support 8 colors
  if [[ "$TERM" = *"256color" ]]; then
    prompt_ick_default_user_color=109
    prompt_ick_default_dir_color=143
    prompt_ick_default_git_color=109
    prompt_ick_default_result_color=143
    prompt_ick_default_result_color_error=124
  else
    prompt_ick_default_user_color=cyan
    prompt_ick_default_dir_color=yellow
    prompt_ick_default_git_color=cyan
    prompt_ick_default_result_color=yellow
    prompt_ick_default_result_color_error=red
  fi

  # プロンプトの設定
  setopt prompt_subst
  PROMPT='$(prompt_command_result) $(user_with_host) $(prompt_dir)$(git_prompt_info) %# '

  # 右プロンプトの設定を削除
  RPROMPT=''
}

prompt_ick_setup
