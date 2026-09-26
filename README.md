# mac-dot

Personal dotfiles for macOS (with Linux/Ubuntu support via `apt`/Homebrew-on-Linux) — zsh only, framework-free (no Oh My Zsh/zinit: plugins are cloned straight from GitHub by `zsh/plugins.zsh`). Covers shell, vim, tmux, htop, Ghostty and a set of cheatsheet functions for both the terminal tools and macOS itself.

## Files and links

| Source file             | Destination                                  |
|--------------------------|-----------------------------------------------|
| `zshenv`                 | `~/.zshenv`                                   |
| `zsh/`                   | `~/.config/zsh` (`$ZDOTDIR`, whole directory symlinked) |
| `vimrc`                  | `~/.vimrc`                                    |
| `tmux.conf`              | `~/.config/tmux/tmux.conf`                    |
| `htoprc`                 | `~/.config/htop/htoprc`                       |
| `glow.yml`               | `~/.config/glow/glow.yml`                     |
| `fastfetch_config.json`  | `~/.config/fastfetch/config.jsonc`            |
| `ssh.sh` / `weather.sh`  | `~/.config/tmux/scripts/`                     |
| `ghostty.config`         | `~/.config/ghostty/config`                    |

`ssh.sh` and `weather.sh` feed the tmux status bar (active outbound SSH target, and Lisboa/Seixal weather via `wttr.in`). Unlike the server/desktop repos, both are present here since this targets an interactive machine, not a headless box.

`zshenv` sets `ZDOTDIR="$HOME/.config/zsh"`, which is a symlink to this repo's `zsh/` directory — so `.zshrc` and every module below live and are edited directly inside this repo checkout, no separate copy step needed after the first install.

### `zsh/` modules

Unlike the numbered `bash_tools.d`/`zsh_tools.d` style in the other two dotfiles repos, modules here are flat, theme-named files sourced by `zsh/.zshrc`:

| Module | Contents |
|---|---|
| `exports.zsh` | env vars (`EDITOR`, `LANG`, `KUBECONFIG`), colorized man pages, ANSI color vars used by `cheatsheet.zsh` |
| `aliases.zsh` | `eza`/`bat` aliases, navigation (`ddir`, `zdir`, `wdir`, ...), tmux, clipboard (`pbcopy`/`pbpaste` on macOS, `xclip` on Linux) |
| `git.zsh` | own port of Oh My Zsh's `git` plugin aliases (`gst`, `gco`, `gcb`, `ggp`, ...) — kept so the muscle memory survives without the framework. Documented in `zfo git` |
| `kubectl.zsh` | read-mostly `kubectl` aliases for an ArgoCD-managed cluster (no `apply`/`edit`/`delete`/`scale` on purpose) plus `kn`/`knls` for namespace switching without `list namespaces` RBAC. Documented in `zfo kubectl` |
| `functions.zsh` | generic utilities: `field`, `epoch`, `explain`, `lintsh`/`fmtsh`, `hl` (pipe a command through `bat`) |
| `bindings.zsh` | keybindings re-applied in `zvm_after_init` (zsh-vi-mode resets bindings on init, so anything custom has to live in that hook) |
| `plugins.zsh` | the from-scratch plugin manager (`_zplugin_load`, `zplugin-update`) — clones `zsh-autosuggestions`, `zsh-history-substring-search`, `zsh-vi-mode`, `fast-syntax-highlighting` into `zsh/plugins/` (gitignored) on first run |
| `prompt.zsh` | Starship init |
| `starship.toml` | prompt config (`$STARSHIP_CONFIG` points here, set in `zshenv`) |
| `cheatsheet.zsh` | `vimfo`, `tmuxfo`, `macfo`, `zfo`, `keys` — see below |
| `local.zsh.example` | template for `zsh/local.zsh` (gitignored) — machine-specific overrides that shouldn't be committed |
| `.zshrc` | orchestrator: history/completion setup, sources every module above in order, then `plugins.zsh` last |

## Installation

Requires `git` and `curl`. Supports macOS (Homebrew) and Ubuntu/Debian (`apt`, optionally Homebrew-on-Linux — see `WANT_BREW_ON_LINUX` in `install.sh`).

```bash
git clone https://github.com/gsousa7/mac-dot.git ~/git/personal/mac-dot
cd ~/git/personal/mac-dot
./install.sh -i
```

`install.sh -i --dry-run` simulates every step without changing anything. Toggles near the top of the script (`WANT_KUBECTL`, `WANT_AWSCLI`, `WANT_TERRAFORM`, `WANT_FONTS`, `WANT_GHOSTTY`, `SET_DEFAULT_SHELL_ZSH`, ...) control what gets installed. Existing files at the destination are backed up to `~/.dotfiles-backup/<timestamp>/` before being replaced with symlinks; `install.sh -u` re-links without touching packages.

## Cheatsheets

All of these are zsh functions from `zsh/cheatsheet.zsh`, available in any shell with this repo's `zshrc` loaded:

| Command | Shows | Usage |
|---|---|---|
| `vimfo` | This repo's actual vim keymap (leader is Space, ALE/fugitive/gitgutter/commentary/rainbow bindings) | `vimfo` (no args) |
| `tmuxfo` | This repo's actual tmux keymap (prefix `Ctrl a`, pane/window management, TPM plugins) | `tmuxfo` (no args) |
| `macfo [section]` | macOS keyboard shortcuts — window management, system/lock, screenshots, text editing, Finder, Firefox, iTerm2/Ghostty, Spotlight, accessibility | `macfo` with no section (or an unknown one) prints the section list |
| `zfo [section]` | The extra OMZ-style `git`/`kubectl` aliases defined in `git.zsh`/`kubectl.zsh` (kept in sync with those files on purpose — see the header comment in each) | `zfo git`, `zfo kubectl`, or `zfo` for both |
| `keys [section]` | AeroSpace/AltTab/Sketchybar window-manager keybindings, multi-monitor setup and troubleshooting | `keys` alone shows the section menu; `keys all` renders the full `cheatsheet.md` via `glow` |

`keys` reads from an external Markdown file (`$KEYS_MD`, defaulting to `~/git/personal/mac-dot/cheatsheet.md`) rather than embedding the content in this script — that file is expected to live alongside this repo but isn't itself tracked here, since AeroSpace/Sketchybar have their own config (outside this repo's scope). If that file doesn't exist on a given machine, only `keys all` (and the `_keys_all` glow/bat/cat fallback) will fail; the other `keys` sections are self-contained.

## Notes

- No numbered-module convention here (unlike `bash_tools.d`/`zsh_tools.d` in the other two repos) — `zsh/.zshrc` sources each theme file by name, in a fixed order it defines directly.
- `git.zsh`/`kubectl.zsh` were the *source* that the desktop `~/dotfiles` repo's `20-git.zsh`/`40-kubernetes.zsh` extra aliases (and `zfo`) were ported from — keep that in mind if muscle memory should stay consistent across machines.
- `zsh/local.zsh` (gitignored, see `local.zsh.example`) is the place for anything machine-specific that shouldn't be committed.
