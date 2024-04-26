#!/usr/bin/env zsh

# zsh-transient-prompt
# pre-alpha
# April 26 2024
# https://codeberg.org/olets/zsh-transient-prompt
# Copyright (©) 2024-present Henry Bley-Vroman

typeset -gi TRANSIENT_PROMPT_FIRST_LINE

function set_prompt() {
  # Optionally set the values of any of PROMPT,
  # RPROMPT, TRANSIENT_PROMPT, and/or
  # TRANSIENT_RPROMPT here

  PROMPT="%~"$'\n''%# '
  (( TRANSIENT_PROMPT_FIRST_LINE )) || PROMPT=$'\n'$PROMPT

  RPROMPT='%(?..%B%F{1}%?%f%b)'
  TRANSIENT_PROMPT='%# '
}

function _transient_prompt_init() {
  [[ -c /dev/null ]]  ||  return
  zmodload zsh/system ||  return

  TRANSIENT_PROMPT_FIRST_LINE=1

  set_prompt

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
  set_prompt
  zle reset-prompt
  zle -R
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
  zle && PROMPT=${TRANSIENT_PROMPT-$PROMPT} RPROMPT=${TRANSIENT_RPROMPT-$RPROMPT} zle reset-prompt && zle -R
}

_transient_prompt_init
