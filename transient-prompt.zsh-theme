#!/usr/bin/env zsh

# zsh-transient-prompt
# 1.0.1
# January 27 2025
# https://github.com/olets/zsh-transient-prompt
# Copyright (©) 2024-present Henry Bley-Vroman

typeset -g TRANSIENT_PROMPT_PROMPT=${TRANSIENT_PROMPT_PROMPT-$PROMPT}
typeset -g TRANSIENT_PROMPT_RPROMPT=${TRANSIENT_PROMPT_RPROMPT-$RPROMPT}
typeset -g TRANSIENT_PROMPT_TRANSIENT_PROMPT=${TRANSIENT_PROMPT_TRANSIENT_PROMPT-$TRANSIENT_PROMPT_PROMPT}
typeset -g TRANSIENT_PROMPT_TRANSIENT_RPROMPT=${TRANSIENT_PROMPT_TRANSIENT_RPROMPT-$TRANSIENT_PROMPT_RPROMPT}
typeset -gA TRANSIENT_PROMPT_ENV

typeset -g TRANSIENT_PROMPT_VERSION=1.0.1

if ! [[ $(whence TRANSIENT_PROMPT_PRETRANSIENT) ]]; then
  function TRANSIENT_PROMPT_PRETRANSIENT() { true }
fi

function _transient_prompt_init() {
  [[ -c /dev/null ]] || return
  zmodload zsh/system || return

  _transient_prompt_toggle_transient 0

  zle -N send-break _transient_prompt_widget-send-break

  zle -N zle-line-finish _transient_prompt_widget-zle-line-finish

  (( ${+precmd_functions} )) || typeset -ga precmd_functions
  (( ${#precmd_functions} )) || {
    do_nothing() {
      true
    }

    precmd_functions=( do_nothing )
  }

  precmd_functions+=_transient_prompt_precmd
}

function _transient_prompt_precmd() {
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
  local key
  local value

  (( ! _transient_prompt_fd )) && {
    sysopen -r -o cloexec -u _transient_prompt_fd /dev/null
    zle -F $_transient_prompt_fd _transient_prompt_restore_prompt
  }

  # cannot use `for key value in ${(kv)…}` because that has undesired results when values are empty
  for key in ${(k)TRANSIENT_PROMPT_ENV}; do
    value=$TRANSIENT_PROMPT_ENV[$key]

    # back up context
    typeset -g _transient_prompt_${key}_saved=${(P)key}

    # apply transient prompt context
    typeset -g "$key"="$value"
  done

  TRANSIENT_PROMPT_PRETRANSIENT
  _transient_prompt_toggle_transient 1

  zle && zle reset-prompt && zle -R

  # restore backed up context
  local key_saved
  for key in ${(k)TRANSIENT_PROMPT_ENV}; do
    typeset key_saved=_transient_prompt_${key}_saved
    typeset -g $key=${(P)key_saved}
    unset $key_saved
  done
}

_transient_prompt_init
unfunction -m _transient_prompt_init
