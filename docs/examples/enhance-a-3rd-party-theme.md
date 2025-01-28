# Enhance a 3rd-party theme

Different 3rd-party themes will support zsh-transient-prompt enhancement to different degrees.

The basic idea is:

1. Install the third-party theme and zsh-transient-prompt
1. Enable the third-party theme, but _not_ zsh-transient-prompt
1. Run `typeset -m $PROMPT`, set `TRANSIENT_PROMPT_PROMPT` to the result
1. Set `TRANSIENT_PROMPT_TRANSIENT_PROMPT` to something else
1. With the third-party theme still enabled, enable zsh-transient-prompt

## Pure, with transient prompt

Here's the start of enhancing Sindre Sorhus's [Pure](https://github.com/sindresorhus/pure) prompt. This is proof-of-concept and has edges you may find unacceptable — for example if you `ctrl-c`, the following prompt isn't preceded by a blank line.

- Prompt is Pure's.
- Transient prompt is the Pure prompt character, colored according to the command's return value.

`.zshrc`

```shell
###
# Pure enhanced with transient prompt, from the zsh-transient-prompt README
###

TRANSIENT_PROMPT_PROMPT=$'%F{${prompt_pure_colors[path]}}%~%f\n%{\C-M%}%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})${prompt_pure_state[prompt]}%f '

TRANSIENT_PROMPT_TRANSIENT_PROMPT='%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})${prompt_pure_state[prompt]} %f'

# load sindresorhus/pure here
# load olets/zsh-transient-prompt here
```

Terminal (in real life this would have colors too)

```
❯ echo transient prompt
transient prompt

❯ cd ~/Projects/olets/my-git-repo

~/Projects/olets/my-git-repo main*
❯
```
