# Basic

::: tip Update
Sample configuration simplified 1/29/2025
:::

This example demonstrates distinct current and past [left] prompts and right prompts.

- Prompt is a blank line, PWD, then a line break, then `%` or -if user is privileged- `#`
- Right prompt is the previous command's non-zero exit code, if any, in bold red
- Transient prompt is `%` or -if user is privileged- `#`
- Transient right prompt is empty

```shell
###
# Minimal prompt config from the zsh-transient-prompt README
###

TRANSIENT_PROMPT_PROMPT=$'\n''%~'$'\n''%# '
TRANSIENT_PROMPT_RPROMPT='%(?..%B%F{1}%?%f%b)'
TRANSIENT_PROMPT_TRANSIENT_PROMPT='%# '
TRANSIENT_PROMPT_TRANSIENT_RPROMPT=

# load olets/zsh-transient-prompt here
```

Terminal

```
% echo transient prompt
transient prompt
% cd ~/olets/my-git-repo
~/olets/my-git-repo
% false

~/olets/my-git-repo
%                                             1
```
