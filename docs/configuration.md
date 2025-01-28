# Configuration

## Options

| Option                               | Type              | Default                     | Description                                                            |
| ------------------------------------ | ----------------- | --------------------------- | ---------------------------------------------------------------------- |
| `TRANSIENT_PROMPT_ENV`               | associative array | `( )`                       | Variables set when redrawing the previous command's prompt and rprompt |
| `TRANSIENT_PROMPT_PRETRANSIENT`      | function          | `{ true }`                  | Run before redrawing the previous command's prompt and rprompt         |
| `TRANSIENT_PROMPT_PROMPT`            | scalar            | `$PROMPT`                   | The current command line's prompt                                      |
| `TRANSIENT_PROMPT_RPROMPT`           | scalar            | `$RPROMPT`                  | The current command line's right prompt                                |
| `TRANSIENT_PROMPT_TRANSIENT_PROMPT`  | scalar            | `$TRANSIENT_PROMPT_PROMPT`  | Previous command lines' prompt                                         |
| `TRANSIENT_PROMPT_TRANSIENT_RPROMPT` | scalar            | `$TRANSIENT_PROMPT_RPROMPT` | Previous command lines' right prompt                                   |

## Exported variables

| Option                     | Type   | Description                                 |
| -------------------------- | ------ | ------------------------------------------- |
| `TRANSIENT_PROMPT_VERSION` | scalar | The running version of zsh-transient-prompt |
