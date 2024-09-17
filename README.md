# zsh-transient-prompt

Add a transient prompt to your zsh command line.

Use it as your theme. Or to add transient prompt support to an existing theme (implementation complexity will depend on the existing theme).

> &nbsp;
>
> 💅 Don't want to write your own theme? Check out mine, [Hometown](https://hometown-prompt.olets.dev/). It supports transient prompt!
>
> &nbsp;

## Installation

### Plugin

You can install zsh-transient-prompt with a zsh plugin manager. Each has their own way of doing things. See your package manager's documentation or the [zsh plugin manager plugin installation procedures gist](https://gist.codeberg.org/olets/06009589d7887617e061481e22cf5a4a).

After adding the plugin to the manager, it will be available in all new terminals. To use it in an already-open terminal, restart zsh in that terminal:

```shell:no-line-numbers
exec zsh
```

### Manual

Either clone this repo and add `source path/to/transient-prompt.zsh-theme` to your `.zshrc`, or

1. Download [the latest zsh-transient-prompt binary](https://codeberg.org/olets/zsh-transient-prompt/releases/latest)
1. Put the file `transient-prompt.zsh-theme` in a directory in your `PATH`

## Usage

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

See the [Recipes](#recipes) below for more.

## Options

Option | Type | Default | Description
---|---|---|---
`TRANSIENT_PROMPT_ENV` | associative array | `( )` | Variables set when redrawing the previous command's prompt and rprompt
`TRANSIENT_PROMPT_PRETRANSIENT` | function | `{ true }` | Run before redrawing the previous command's prompt and rprompt
`TRANSIENT_PROMPT_PROMPT` | scalar | `$PROMPT` | The current command line's prompt
`TRANSIENT_PROMPT_RPROMPT` | scalar | `$RPROMPT` | The current command line's right prompt
`TRANSIENT_PROMPT_TRANSIENT_PROMPT` | scalar | `$TRANSIENT_PROMPT_PROMPT` | Previous command lines' prompt
`TRANSIENT_PROMPT_TRANSIENT_RPROMPT` | scalar | `$TRANSIENT_PROMPT_RPROMPT` | Previous command lines' right prompt

## Exported variables

Option | Type | Description
---|---|---
`TRANSIENT_PROMPT_VERSION` | scalar | The running version of zsh-transient-prompt

## Recipes

1. Basic:

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

    ```
    % echo transient prompt
    transient prompt
    % cd ~/olets/my-git-repo
    ~/olets/my-git-repo
    % false

    ~/olets/my-git-repo
    %                                             1
    ```

1. Git-aware, using [Git Prompt Kit](https://git-prompt-kit.olets.dev/) for high-performance Git content. This enhances GPK's [basic example](https://git-prompt-kit.olets.dev/example.html).

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

    ```
    % echo transient prompt
    transient prompt
    % cd ~/Projects/olets/my-git-repo

    olets/my-git-repo main +2 % 
    ```

1. Add transient prompt as an enhancement to Sindre Sorhus's [Pure](https://github.com/sindresorhus/pure) prompt. This is proof-of-concept and may have unacceptable rough edges — for example if you `ctrl-c`, the following prompt isn't preceded by a blank line.

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

    ```
    
    ❯ echo transient prompt
    transient prompt

    ❯ cd ~/Projects/olets/my-git-repo

    ~/Projects/olets/my-git-repo main*
    ❯ 
    ```

1. Git-aware Pure-like prompt, using [Git Prompt Kit](https://git-prompt-kit.olets.dev/) for high-performance Git content. This enhances GPK's [Pure-like recipe](https://git-prompt-kit.olets.dev/recipes.html#pure-like).

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

    ```
    
    ❯ echo transient prompt
    transient prompt

    ❯ cd ~/Projects/olets/my-git-repo

    ~/Projects/olets/my-git-repo main ⇡1
    ❯ 
    ```

## Changelog

See the [CHANGELOG](CHANGELOG.md) file.

## Contributing

Thanks for your interest. Contributions are welcome!

> Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

Check the [Issues](https://codeberg.org/olets/zsh-transient-prompt/issues) to see if your topic has been discussed before or if it is being worked on. You may also want to check the roadmap (see above).

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## License

<a href="https://codeberg.org/olets/zsh-transient-prompt">zsh-transient-prompt</a> by <a href="https://codeberg.org/olets">Henry Bley-Vroman</a> is released under the [MIT license](LICENSE).

## Acknowledgments

zsh-transient-prompt builds off Roman Perepelitsa's [powerlevel10k](https://codeberg.org/romkatv/powerlevel10k), via Subhaditya Nath's [transient_prompt.zsh](https://gist.codeberg.org/subnut/3af65306fbecd35fe2dda81f59acf2b2).
