<script setup>
import { NuAsciinemaPlayer } from "@nolebase/ui-asciinema";
import "asciinema-player/dist/bundle/asciinema-player.css";
</script>

Here's a screencast of [Hometown prompt](https://hometown-prompt.olets.dev) as an example. When you "accept" the command line (that is, hit <kbd>Enter</kbd>) the prompt trims down.

<!-- DUPE hometown-prompt@v4 README.md hometown-prompt-docs@v4 docs/parts/screencast.md, zsh-transient-prompt@v1 docs/parts/screencast.md -->
<details><summary>Toggle to show/hide an annotated transcript</summary>

```shell
mkdir -p repo/child/grandchild/great-grandchild
cd repo

# cwd changes to current dir
# previous prompt simplifies: cwd has only one segment

git init

# cwd changes to underline Git repo root; Git branch and its appear

cd child

# cwd changes to current dir. segments start at repo root's parent

cd grandchild

# cwd changes as before
# previous prompt simplifies: cwd starts at the repo root

cd great-grandchild

# cwd changes. shows at most repo root's parent, repo root, ellipsis, cwd parent, cwd

git init

# cwd changes to underlined repo root, and parent

touch x y

# Git status changes

git add -A

# Git status changes, Git branch color changes

git commit -m first

# Git status changes, Git branch color changes

git switch -c feature

# Git branch changes, Git branch color changes

echo wip >> x

# Git status changes, Git branch color changes

git stash

# Git stash appears, Git status changes, Git branch color changes

echo a >> x

# Git status changes

rm y

# Git status changes

git add .

# Git status changes

git commit -m second

# Git status changes, Git branch color changes

git stash drop

# Git stash disappears

git switch main

# Git branch changes

echo b >> x

# Git status changes, Git branch color changes

git commit -am third

# Git status changes, Git branch color changes

git rebase @ feature

# Git HEAD changes, Git HEAD color changes, Git status changes, Git action appears, prompt character color changes

git checkout —ours x

# Git status changes, Git action appears, prompt character color changes

git add x

# Git HEAD changes, Git HEAD color changes, Git status changes, Git action appears

git rebase —continue —no-edit
```

</details>

<NuAsciinemaPlayer
  src="https://v4.hometown-prompt.olets.dev/hometown-prompt-v4-demo.cast"
  :preload="true"
  :controls="true"
  cols="95"
  rows="20"
  terminal-font-size="16px"
  poster="npt:0:01"
  speed="1.5"
/>
