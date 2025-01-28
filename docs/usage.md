# Usage

`zsh-transient-prompt`'s default prompt is zsh's default prompt. So simply installing and loading `zsh-transient-prompt` will not change anything.

At the very least, set the variable `TRANSIENT_PROMPT_TRANSIENT_PROMPT` (that's not a typo. The `zsh-transient-prompt` configuration variables are `TRANSIENT_PROMPT_<key>`). For example

`.zshrc`

```shell
TRANSIENT_PROMPT_TRANSIENT_PROMPT='% '
# load zsh-transient-prompt here here
```

Terminal

```shell
% echo transient prompt
transient prompt
% cd ~/my-git-repo
olets@olets.dev my-git-repo %
```

See the zsh prompt expansion documentation <https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html> to learn about what dynamic information out-of-the-box zsh can display in prompts.

To add transient prompt support to your existing prompt, start by running `typeset -m PROMPT`. Then in `.zshrc`, set `TRANSIENT_PROMPT_TRANSIENT_PROMPT` to that value, in single quotations (`''`).
