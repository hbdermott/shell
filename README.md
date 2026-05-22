# shell

Personal WSL environment bootstrap. Sets up a Zsh-based development shell with common tools, plugins, and themes.

## What it installs

- **Shell packages:** zsh, git, curl, wget, fzf, ripgrep, bat, micro, pipx, eza, fd-find
- **oh-my-zsh** with plugins:
  - zsh-autocomplete
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - fzf-tab
- **Lazygit** — terminal UI for Git
- **nvm (Node Version Manager)** — manage Node.js versions
- **tldr** — simplified man pages (via pipx)
- **elessar** zsh theme
- **z.sh** — directory jumping

## Usage

```bash
./shell.sh
```

The script detects your package manager (`apt`, `dnf`, `pacman`, or `brew`) and installs everything accordingly. After it finishes, restart your shell or run `source ~/.zshrc`.

## Files

| File | Purpose |
|---|---|
| `shell.sh` | Bootstrap script — installs packages, tools, plugins, and deploys `.zshrc` |
| `.zshrc` | Zsh configuration template (deployed to `~/.zshrc`) |
| `README.md` | This file |

## Notes

- Designed for WSL but works on any Linux or macOS environment.
- Runs with elevated privileges via `sudo` for system package installation.
- Idempotent — safe to re-run; skips already-installed tools.
