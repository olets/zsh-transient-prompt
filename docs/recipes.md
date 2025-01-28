# Examples

## Basic

```shell
###
# Minimal prompt config from the zsh-transient-prompt README
###

# Prompt is a line break if this isn't the first command line, then CWD, then a line break, then `%` or -if user is privileged- `#`
TRANSIENT_PROMPT_PROMPT='%(2v.'$'\n.)%~'$'\n''%# '

# Right prompt is the previous command's non-zero exit code, if any, in bold red
TRANSIENT_PROMPT_RPROMPT='%(?..%B%F{1}%?%f%b)'

# Transient prompt is `%` or -if user is privileged- `#`
TRANSIENT_PROMPT_TRANSIENT_PROMPT='%# '

# Transient right prompt is empty
TRANSIENT_PROMPT_TRANSIENT_RPROMPT=

# enable zsh's add-zsh-hook function
autoload -Uz add-zsh-hook

# add a "precmd" hook to run the function precmd_set_psvar before drawing the prompt
add-zsh-hook precmd precmd_set_psvar

function precmd_set_psvar() {
  # append an element to the psvar array every prompt for the first two prompts
  (( psvar[2] )) && return
  psvar+=( 1 )
}

# load olets/zsh-transient-prompt here
```

Terminal

```shell
% echo transient prompt
transient prompt
% cd ~/olets/my-git-repo
~/olets/my-git-repo
% false

~/olets/my-git-repo
%                                             1
```

## Basic Git-aware

Using [Git Prompt Kit](https://git-prompt-kit.olets.dev/) for high-performance Git content. This enhances GPK's [basic example](https://git-prompt-kit.olets.dev/example.html).

```shell
###
# Git-aware prompt using Git Prompt Kit, from the zsh-transient-prompt README
###

# Transient prompt is the prompt character
TRANSIENT_PROMPT_TRANSIENT_PROMPT=''


# Transient prompt is the prompt character
TRANSIENT_PROMPT_TRANSIENT_PROMPT='$GIT_PROMPT_KIT_CHAR '

# Prompt is
# a line break if this isn't the first command line
TRANSIENT_PROMPT_PROMPT='%(2v.'$'\n.)'
# the CWD
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CWD '
# if in a Git repo, the branch or commit, number of commits ahead and/or behind, upstream if set, push remote and number of commits ahead/behind if it's distinct from the upstream, and up to one tag at HEAD
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_REF:+$GIT_PROMPT_KIT_REF }'
# and the prompt character
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CHAR '

# load zsh's add-zsh-hook function here
autoload -Uz add-zsh-hook

# add a "precmd" hook to run the function precmd_set_psvar before drawing the prompt
add-zsh-hook precmd precmd_set_psvar

function precmd_set_psvar() {
  # append an element to the psvar array every prompt for the first two prompts
  (( psvar[2] )) && return
  psvar+=( 1 )
}

# load olets/git-prompt-kit here
# load olets/zsh-transient-prompt here
```

Terminal (in real life this would have colors too)

```shell
% echo transient prompt
transient prompt
% cd ~/Projects/olets/my-git-repo

olets/my-git-repo main +2 %
```

## Enhance your existing prompt

Add transient prompt as an enhancement to Sindre Sorhus's [Pure](https://github.com/sindresorhus/pure) prompt. This is proof-of-concept and may have unacceptable rough edges — for example if you `ctrl-c`, the following prompt isn't preceded by a blank line.

`.zshrc`

```shell
###
# Pure enhanced with transient prompt, from the zsh-transient-prompt README
###

# Prompt is the result of enabling Pure and then running `typeset -m $PROMPT`
TRANSIENT_PROMPT_PROMPT=$'%F{${prompt_pure_colors[path]}}%~%f\n%{\C-M%}%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})${prompt_pure_state[prompt]}%f '

# Transient prompt is the Pure prompt character, colored according to the command's return value
TRANSIENT_PROMPT_TRANSIENT_PROMPT='%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})${prompt_pure_state[prompt]} %f'

# load sindresorhus/pure here
# load olets/zsh-transient-prompt here
```

Terminal (in real life this would have colors too)

```shell
❯ echo transient prompt
transient prompt

❯ cd ~/Projects/olets/my-git-repo

~/Projects/olets/my-git-repo main*
❯
```

## Git-aware Pure-like prompt

Uses [Git Prompt Kit](https://git-prompt-kit.olets.dev/) for high-performance Git content. This enhances GPK's [Pure-like recipe](https://git-prompt-kit.olets.dev/recipes.html#pure-like).

```shell
###
# Pure-like Git Prompt Kit-driven prompt, from the zsh-transient-prompt README
###

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

GIT_PROMPT_KIT_COLOR_ACTION=242
GIT_PROMPT_KIT_COLOR_ASSUME_UNCHANGED=cyan
GIT_PROMPT_KIT_COLOR_CWD=blue
GIT_PROMPT_KIT_COLOR_FAILED=red
GIT_PROMPT_KIT_COLOR_HEAD="#6c6c6c"
GIT_PROMPT_KIT_COLOR_HOST=242
GIT_PROMPT_KIT_COLOR_REMOTE=cyan
GIT_PROMPT_KIT_COLOR_SKIP_WORKTREE=cyan
GIT_PROMPT_KIT_COLOR_STASH=cyan
GIT_PROMPT_KIT_COLOR_SUCCEEDED=magenta
GIT_PROMPT_KIT_COLOR_USER=242
GIT_PROMPT_KIT_CWD_MAX_TRAILING_COUNT=-1
GIT_PROMPT_KIT_GIT_STATUS_ON_OWN_LINE=0
GIT_PROMPT_KIT_REPO_SUBDIRECTORY_MAX_TRAILING_COUNT=-1
GIT_PROMPT_KIT_SHOW_INACTIVE_STATUS=0
GIT_PROMPT_KIT_SYMBOL_AHEAD=⇡
GIT_PROMPT_KIT_SYMBOL_BEHIND=⇣
GIT_PROMPT_KIT_SYMBOL_CHAR_NORMAL=❯
GIT_PROMPT_KIT_SYMBOL_STASH=≡

# Build prompt
TRANSIENT_PROMPT_PROMPT=$'\n'
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CWD'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_HEAD:+ $GIT_PROMPT_KIT_HEAD}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_ACTION:+ $GIT_PROMPT_KIT_ACTION}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_BEHIND:+ $GIT_PROMPT_KIT_BEHIND}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_AHEAD:+ $GIT_PROMPT_KIT_AHEAD}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_STATUS_EXTENDED:+ $GIT_PROMPT_KIT_STATUS_EXTENDED}'
TRANSIENT_PROMPT_PROMPT+=$'\n'
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CHAR '
TRANSIENT_PROMPT_TRANSIENT_PROMPT+='$GIT_PROMPT_KIT_CHAR '

# load olets/git-prompt-kit here
# load olets/zsh-transient-prompt here
```

Terminal (in real life this would have colors too. More Git information would be displayed than in real Pure, and more quickly.)

```shell
❯ echo transient prompt
transient prompt

❯ cd ~/Projects/olets/my-git-repo

~/Projects/olets/my-git-repo main ⇡1
❯
```
