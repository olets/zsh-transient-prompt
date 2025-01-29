# Basic Git-aware

::: tip Update
Sample configuration simplified 1/29/2025
:::

This example uses [Git Prompt Kit](https://git-prompt-kit.olets.dev/) for high-performance Git content. This enhances GPK's [basic example](https://git-prompt-kit.olets.dev/examples.html#use-git-prompt-kit-components-instead-of-opaque-code).

- Transient prompt is the prompt character
- Prompt is
  1. a blank line
  1. the CWD
  1. if in a Git repo, the branch or commit, number of commits ahead and/or behind, upstream if set, push remote and number of commits ahead/behind if it's distinct from the upstream, and up to one tag at HEAD
  1. Line break
  1. the prompt character

```shell
###
# Git-aware prompt using Git Prompt Kit, from the zsh-transient-prompt README
###

TRANSIENT_PROMPT_TRANSIENT_PROMPT='$GIT_PROMPT_KIT_CWD '
TRANSIENT_PROMPT_TRANSIENT_PROMPT+='$GIT_PROMPT_KIT_CHAR '
TRANSIENT_PROMPT_PROMPT=$'\n'
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CWD'
TRANSIENT_PROMPT_PROMPT+='${GIT_PROMPT_KIT_REF:+ $GIT_PROMPT_KIT_REF}'
TRANSIENT_PROMPT_PROMPT+=$'\n'
TRANSIENT_PROMPT_PROMPT+='$GIT_PROMPT_KIT_CHAR '
# load olets/git-prompt-kit here
# load olets/zsh-transient-prompt here
```

Terminal (in real life this would have colors too)

```
~ % echo transient prompt
transient prompt
~ % cd ~/Projects/olets/my-git-repo

olets/my-git-repo main +2
%
```
