# Basic

- Prompt is a line break if this isn't the first command line, then CWD, then a line break, then `%` or -if user is privileged- `#`
- Right prompt is the previous command's non-zero exit code, if any, in bold red
- Transient prompt is `%` or -if user is privileged- `#`
- Transient right prompt is empty

```shell
###
# Minimal prompt config from the zsh-transient-prompt README
###

TRANSIENT_PROMPT_PROMPT='%(2v.'$'\n.)%~'$'\n''%# '
TRANSIENT_PROMPT_RPROMPT='%(?..%B%F{1}%?%f%b)'
TRANSIENT_PROMPT_TRANSIENT_PROMPT='%# '
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

```
% echo transient prompt
transient prompt
% cd ~/olets/my-git-repo
~/olets/my-git-repo
% false

~/olets/my-git-repo
%                                             1
```
