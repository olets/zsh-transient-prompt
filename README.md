# zsh-transient-prompt

Add a transient prompt to your zsh command line.

Use it as your theme. Or to add transient prompt support to an existing theme (implementation complexity will depend on the existing theme).

> 💅 Don't want to write your own theme? Check out mine, [Hometown](https://hometown-prompt.olets.dev/).

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

`.zshrc`

```shell
# load zsh-transient-prompt here
```

Terminal

```shell
dev@olets zsh-transient-prompt % echo transient
transient
dev@olets zsh-transient-prompt % echo prompt
prompt
dev@olets zsh-transient-prompt %
```

At the very least, set the variable `TRANSIENT_PROMPT_TRANSIENT_PROMPT` (that's not a typo. The `zsh-transient-prompt` configuration variables are `TRANSIENT_PROMPT_<key>`). For example

`.zshrc`

```shell
TRANSIENT_PROMPT_TRANSIENT_PROMPT='% '
# load zsh-transient-prompt here
```

Terminal

```shell
% echo transient
transient
% echo prompt
prompt
dev@olets zsh-transient-prompt %
```

See the zsh prompt expansion documentation <https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html> to learn what all you can do, or check out the [Examples](#examples) below.

## Options

Option | Type | Default | Notes
---|---|---|---
`TRANSIENT_PROMPT_ENV` | associative array | `( )` | Variables set when redrawing the previous command's prompt and rprompt
`TRANSIENT_PROMPT_PRETRANSIENT` | function | `{ true }` | Run before redrawing the previous command's prompt and rprompt
`TRANSIENT_PROMPT_PROMPT` | string | `$PROMPT` | The current command line's prompt
`TRANSIENT_PROMPT_RPROMPT` | string | `$RPROMPT` | The current command line's rprompt
`TRANSIENT_PROMPT_TRANSIENT_PROMPT` | string | `$TRANSIENT_PROMPT_PROMPT` | Previous command lines' prompt
`TRANSIENT_PROMPT_TRANSIENT_RPROMPT` | string | `$TRANSIENT_PROMPT_RPROMPT` | Previous command lines' rprompt

## Exports

Export | Type | Notes
---|---|---
`TRANSIENT_PROMPT_FIRST_LINE` | integer | `1` if on the first line, otherwise `0`

## Examples

1. With the following configuration, the active command line's prompt is a linebreak, then CWD, then another linebreak, then % or # depending on whether the user does not or does have privileges, and over on the right the previous command's exit code if not zero; previous commands' prompts are simply % or # depending on whether the user did not or did have privileges.

    `.zshrc`

    ```shell
    # configure zsh-transient-prompt
    TRANSIENT_PROMPT_PROMPT='%(1v.'$'\n.)%~'$'\n''%# '
    TRANSIENT_PROMPT_RPROMPT='%(?..%B%F{1}%?%f%b)'
    TRANSIENT_PROMPT_TRANSIENT_PROMPT='%# '
    TRANSIENT_PROMPT_TRANSIENT_RPROMPT=

    # load the add-zsh-hook function which ships with zsh
    autoload -Uz add-zsh-hook

    # add a "precmd" hook to run the function precmd_set_psvar before drawing the prompt
    add-zsh-hook precmd precmd_set_psvar

    function precmd_set_psvar() {
      # reset the psvar array
      psvar=( )

      # if not the first line, add an element to psvar
      (( TRANSIENT_PROMPT_FIRST_LINE )) || psvar+=( 1 )
    }

    # load zsh-transient-prompt here
    ```

    Terminal

    ```shell
    % echo transient
    transient
    % echo prompt
    prompt
    % ctrl-c'd

    ~/olets/zsh-transient-prompt
    %                                             130
    ```

1. Add transient prompt as an enhancement to [Pure](https://codeberg.org/sindresorhus/pure). This is proof-of-concept and may have unacceptable rough edges — for example if you `ctrl-c`, the following prompt doesn't show the CWD. Values were determined by loading Pure _without_ zsh-transient-prompt and then running `typeset -m PROMPT`.

    `.zshrc`

    ```shell
    TRANSIENT_PROMPT_PROMPT='%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})${prompt_pure_state[prompt]} %f'
    TRANSIENT_PROMPT_TRANSIENT_PROMPT='%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})${prompt_pure_state[prompt]} %f'
    # load pure
    # load zsh-transient-prompt
    ```

    Terminal (in real life this would have colors too)

    ```shell
    ❯ echo transient
    transient

    ❯ echo prompt
    prompt

    ~/olets/zsh-transient-prompt main
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

zsh-transient-prompt builds off Subhaditya Nath's [transient_prompt.zsh](https://gist.codeberg.org/subnut/3af65306fbecd35fe2dda81f59acf2b2), which extracts the transient prompt functionality of Roman Perepelitsa's [powerlevel10k](https://codeberg.org/romkatv/powerlevel10k).
