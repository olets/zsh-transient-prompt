---
titleTemplate: :title # see also VitePress config
outline: false
---

# zsh-transient-prompt

<!-- ![GitHub release (latest by date)](https://img.shields.io/github/v/release/olets/zsh-transient-prompt) ![GitHub commits since latest release](https://img.shields.io/github/commits-since/olets/zsh-transient-prompt/latest) -->

![zsh-transient-prompt splash card](/zsh-transient-prompt-card.jpg)

**zsh-transient-prompt**: Add a transient prompt to your zsh command line — that is, make your current command line's prompt different from past command lines' prompts. For example, past prompts might not need to show as much contextual information. Or you might want to put past commands on their own line, instead of prefixed by a prompt, for easier selecting and copying.

What?

<!--@include: ./parts/screencast.md -->

Or walk through an example. Given the prompt

```
<time when drawn> <directory when drawn> <Git branch when drawn>
```

without transient prompt this will happen:

1. Open a new terminal

   ```
   11:11:00 ~/olets/zsh-transient-prompt main
   %
   ```

1. Run a command

   ```
   11:11:00 ~/olets/zsh-transient-prompt main
   % echo hello world
   hello world

   11:11:47 ~/olets/zsh-transient-prompt main
   %
   ```

Compare that to the same prompt, but with the transient prompt

```
<directory when drawn> %
```

Now this happens:

1. Open a new terminal

   ```
   11:11:00 ~/olets/zsh-transient-prompt main
   %
   ```

1. Run a command

   ```
   ~/olets/zsh-transient-prompt %
   echo hello world
   hello world

   11:11:47 ~/olets/zsh-transient-prompt main
   %
   ```

> &nbsp;
>
> 💅 Don't want to write your own theme? Check out mine, [Hometown](https://hometown-prompt.olets.dev/). It supports transient prompt!
>
> &nbsp;
