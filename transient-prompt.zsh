#!/usr/bin/env zsh

# zsh-transient-prompt
# pre-alpha
# April 26 2024
# https://codeberg.org/olets/zsh-transient-prompt
# Copyright (©) 2024-present Henry Bley-Vroman

# https://gist.github.com/subnut/3af65306fbecd35fe2dda81f59acf2b2, revision March 10 2022
#### Transient prompt with transient newline before prompt

[[ -c /dev/null ]]  ||  return
zmodload zsh/system ||  return

function set_prompt() {
  ## Set the values of PROMPT, RPROMPT, and TRANSIENT_PROMPT here
  PROMPT='%~'$'\n''%# '
  RPROMPT='%(?..%B%F{1}%?%f%b)'
  TRANSIENT_PROMPT='%# '
}

typeset -g _transient_prompt_newline=
function _transient_prompt_set_prompt() {
  set_prompt
  PROMPT=$_transient_prompt_newline$PROMPT
}
_transient_prompt_set_prompt

zle -N clear-screen _transient_prompt_widget-clear-screen
function _transient_prompt_widget-clear-screen() {
  _transient_prompt_newline=
  zle .clear-screen
}

zle -N send-break _transient_prompt_widget-send-break
function _transient_prompt_widget-send-break() {
  _transient_prompt_widget-zle-line-finish
  zle .send-break
}

zle -N zle-line-finish _transient_prompt_widget-zle-line-finish
function _transient_prompt_widget-zle-line-finish() {
  (( ! _transient_prompt_fd )) && {
    sysopen -r -o cloexec -u _transient_prompt_fd /dev/null
    zle -F $_transient_prompt_fd _transient_prompt_restore_prompt
  }
  zle && PROMPT=$TRANSIENT_PROMPT RPROMPT= zle reset-prompt && zle -R
}

function _transient_prompt_restore_prompt() {
  exec {1}>&-
  (( ${+1} )) && zle -F $1
  _transient_prompt_fd=0
  _transient_prompt_set_prompt
  zle reset-prompt
  zle -R
}

(( ${+precmd_functions} )) || typeset -ga precmd_functions
(( ${#precmd_functions} )) || {
  do_nothing() {
    true
  }
  precmd_functions=(do_nothing)
}

precmd_functions+=_transient_prompt_precmd
function _transient_prompt_precmd() {
  # We define _transient_prompt_precmd in this way because we don't want
  # _transient_prompt_newline to be defined on the very first precmd.
  _transient_prompt_newline=$'\n'
  TRAPINT() {
    zle && _transient_prompt_widget-zle-line-finish
    return $(( 128 + $1 ))
  }
}

# vim: sw=0 ts=4 sts=4 et