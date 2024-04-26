# zsh-transient-prompt

Add a transient prompt to your zsh command line.
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
