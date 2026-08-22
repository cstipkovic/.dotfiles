# dotfiles

Personal configuration files for bash, vim, and tmux.

## What's here

- `bash_profile`, `bashrc`, `profile` — bash configuration (aliases, git-aware prompt, toolchain
  setup for Ruby/NVM/Java/Go/Docker/etc). Shared aliases and prompt logic live in `common.sh`,
  sourced by `bash_profile` and `profile`.
- `vim/vimrc` — Vim configuration (Vundle/vim-plug, Dracula theme).
- `tmux/tmux.conf` — tmux configuration.
- `welcome-terminal.txt` — ASCII banner shown on new terminal sessions.
- `install.sh` — symlinks the files above into `$HOME` for the current OS (macOS/Linux).

## Setup

Clone the repo to `~/.dotfiles` and run the installer:

```sh
git clone https://github.com/cstipkovic/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer backs up any existing `~/.bashrc`, `~/.vimrc`, `~/.tmux.conf`, `~/.bash_profile`,
etc. to `<file>.bak-<timestamp>` before creating the symlinks.

### Vim plugins

```sh
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Or, for vim-plug:

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Plugins used: `tpope/vim-markdown`, `tomasr/molokai`, `kien/ctrlp.vim`, `rking/ag.vim`.

### Secrets

API keys and tokens (e.g. `GEMINI_API_KEY`, `GITHUB_PERSONAL_ACCESS_TOKEN`) are **not** stored in
this repo. `profile` sources `~/.dotfiles/secrets.env` if it exists — create that file locally
with your own `export VAR="value"` lines; it's git-ignored.

### Welcome banner

```sh
figlet -w 200 -f small -k "Zdravo,  Mr.  Stipkovic" > ~/.dotfiles/welcome-terminal.txt
```
