# Advanced Git-aware

An approximate recreation of Pure, using [Git Prompt Kit](https://git-prompt-kit.olets.dev/) for high-performance Git content. This enhances GPK's [Pure-like recipe](https://git-prompt-kit.olets.dev/recipes.html#pure-like).

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

# Load Git Prompt Kit (will differ depending on installation method)

# Build prompt
dirty_prompt_marker='%F{218}*%F{$GIT_PROMPT_KIT_COLOR_INACTIVE}'
TRANSIENT_PROMPT_PROMPT=
TRANSIENT_PROMPT_PROMPT+=$'\n'
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CWD'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_HEAD:+ $GIT_PROMPT_KIT_HEAD}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_DIRTY:+$dirty_prompt_marker}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_ACTION:+ $GIT_PROMPT_KIT_ACTION}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_BEHIND:+ $GIT_PROMPT_KIT_BEHIND}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_AHEAD:+ $GIT_PROMPT_KIT_AHEAD}'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_STATUS_EXTENDED:+ $GIT_PROMPT_KIT_STATUS_EXTENDED}'
TRANSIENT_PROMPT_PROMPT+=$'\n'
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CWD '
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CHAR '
TRANSIENT_PROMPT_TRANSIENT_PROMPT+='$GIT_PROMPT_KIT_CHAR '

# load olets/git-prompt-kit here
# load olets/zsh-transient-prompt here
```

Terminal (in real life this would have colors too. More Git information would be displayed than in real Pure, and more quickly.)

```
~ ❯ echo transient prompt
transient prompt

~ ❯ cd ~/Projects/olets/my-git-repo

~/Projects/olets/my-git-repo main ⇡1
❯
```
