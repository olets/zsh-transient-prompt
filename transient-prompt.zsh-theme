#!/usr/bin/env zsh

# zsh-transient-prompt
# pre-alpha
# April 26 2024
# https://codeberg.org/olets/zsh-transient-prompt
# Copyright (©) 2024-present Henry Bley-Vroman

typeset -gi TRANSIENT_PROMPT_FIRST_LINE
typeset -g TRANSIENT_PROMPT_PROMPT=${TRANSIENT_PROMPT_PROMPT-$PROMPT}
typeset -g TRANSIENT_PROMPT_RPROMPT=${TRANSIENT_PROMPT_RPROMPT-$RPROMPT}
typeset -g TRANSIENT_PROMPT_TRANSIENT_PROMPT=${TRANSIENT_PROMPT_TRANSIENT_PROMPT-$TRANSIENT_PROMPT_PROMPT}
typeset -g TRANSIENT_PROMPT_TRANSIENT_RPROMPT=${TRANSIENT_PROMPT_TRANSIENT_RPROMPT-$TRANSIENT_PROMPT_RPROMPT}

function _transient_prompt_init() {
  [[ -c /dev/null ]]  ||  return
  zmodload zsh/system ||  return

  TRANSIENT_PROMPT_FIRST_LINE=1

  _transient_prompt_toggle_transient 0

  zle -N send-break _transient_prompt_widget-send-break

  zle -N zle-line-finish _transient_prompt_widget-zle-line-finish

  (( ${+precmd_functions} )) || typeset -ga precmd_functions
  (( ${#precmd_functions} )) || {
    do_nothing() {
      true
    }
    precmd_functions=(do_nothing)
  }

  precmd_functions+=_transient_prompt_precmd
}

function _transient_prompt_precmd() {
  TRANSIENT_PROMPT_FIRST_LINE=0

  TRAPINT() {
    zle && _transient_prompt_widget-zle-line-finish
    return $(( 128 + $1 ))
  }
}

function _transient_prompt_restore_prompt() {
  exec {1}>&-
  (( ${+1} )) && zle -F $1
  _transient_prompt_fd=0
  _transient_prompt_toggle_transient 0
  zle reset-prompt
  zle -R
}

function _transient_prompt_toggle_transient() {
  local -i transient
  transient=${1-0}

  if (( transient )); then
    PROMPT=$TRANSIENT_PROMPT_TRANSIENT_PROMPT
    RPROMPT=$TRANSIENT_PROMPT_TRANSIENT_RPROMPT

    return
  fi

  PROMPT=$TRANSIENT_PROMPT_PROMPT
  RPROMPT=$TRANSIENT_PROMPT_RPROMPT
}

function _transient_prompt_widget-send-break() {
  _transient_prompt_widget-zle-line-finish
  zle .send-break
}

function _transient_prompt_widget-zle-line-finish() {
  (( ! _transient_prompt_fd )) && {
    sysopen -r -o cloexec -u _transient_prompt_fd /dev/null
    zle -F $_transient_prompt_fd _transient_prompt_restore_prompt
  }
  _transient_prompt_toggle_transient 1
  
  zle && zle reset-prompt && zle -R
}

_transient_prompt_init
