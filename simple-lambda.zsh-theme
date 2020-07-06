#!/usr/bin/env zsh

LAMBDA="%(?,%{$fg_bold[green]%}λ,%{$fg_bold[red]%}λ)%{$reset_color%}"

function get_git_prompt_info() {
  if [[ ! -z $(git_prompt_info 2> /dev/null) ]]; then
    echo "$(git_prompt_info 2> /dev/null) $(git_prompt_status)
$LAMBDA "
  else
    echo "$LAMBDA "
  fi
}

function get_rprompt() {
  if [[ ! -z $(git_prompt_info 2> /dev/null) ]]; then
    [[ ! -z $(git_commits_ahead) ]] && ahead=$(git_commits_ahead) || ahead=0
    [[ ! -z $(git_commits_behind) ]] && behind=$(git_commits_behind) || behind=0

    echo "%{$fg_bold[blue]%}(\
%{$fg_bold[white]%}↑%{$fg_bold[green]%}$ahead%{$reset_color%} \
%{$fg_bold[white]%}↓%{$fg_bold[red]%}$behind%{$reset_color%}\
%{$fg_bold[blue]%})%{$reset_color%}"

  else
    echo "%{$reset_color%}"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%} %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✔"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}~%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}?%{$reset_color%}"

# Main Prompt template.
PROMPT=$'\n''%{$fg[white]%}%n\
%{$fg[blue]%}@\
%{$fg[white]%}%m:\
%{$fg_no_bold[magenta]%}%4~%{$reset_color%} \
$(get_git_prompt_info)\
%{$reset_color%}'

RPROMPT='$(get_rprompt)'

