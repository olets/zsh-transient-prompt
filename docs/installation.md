# Installation

## Package

### Homebrew

zsh-transient-prompt is available on Homebrew. Run

```shell
brew install olets/tap/zsh-transient-prompt
```

and follow the post-install instructions logged to the terminal.

:::tip
`brew upgrade` will upgrade you to the latest version, even if it's a major version change.

Want to stay on the major version you instaled until you _choose_ to upgrade to the next? When installing zsh-transient-prompt with Homebrew for the first time, run

```shell
brew install olets/tap/zsh-transient-prompt@<major version>
# e.g.
# brew install olets/tap/zsh-transient-prompt@1
```

If you've already installed `olets/tap/zsh-transient-prompt` with Homebrew, you can switch to a major version's formula by running

```shell
brew uninstall --force zsh-transient-prompt
```

and then

```shell
brew install olets/tap/zsh-transient-prompt@<major version>
# e.g.
# brew install olets/tap/zsh-transient-prompt@6
```

:::

## Plugin

You can install zsh-transient-prompt with a zsh plugin manager, including those built into frameworks such as Oh-My-Zsh (OMZ) and prezto. Each has their own way of doing things. Read your package manager's documentation or the [zsh plugin manager plugin installation procedures gist](https://gist.github.com/olets/06009589d7887617e061481e22cf5a4a).

:::tip
Want to stay on a particular major version until you _choose_ to upgrade to the next? Use your package manager's convention for specifying the branch `v<major version>`, e.g. `v1`.
:::

After adding the plugin to the manager, it will be available in all new terminals. To use it in an already-open terminal, restart zsh in that terminal:

```shell
exec zsh
```

## Manual

- Either download the archive of the release of your choice from <https://codeberg.org/olets/zsh-transient-prompt/releases> and expand it. Follow the release notes.

- or clone a single branch:

  ```shell
  git clone https://codeberg.org/olets/zsh-transient-prompt  --single-branch --branch <branch> --depth 1
  ```

  Replace `<branch>` with a branch name. Good options are `main` (for the latest stable release), `next` (for the latest release, even if it isn't stable), or a major version for example `v1`.

Then add `source path/to/transient-prompt.zsh-theme` to your `.zshrc` (replace `path/to/` with the real path), and restart zsh:

```shell
exec zsh
```

### Updating

If you downloaded an archive, download the latest and update your `.zshrc` if necessary.

If you cloned the repo, `cd` into the clone and run

```shell
git pull
```
