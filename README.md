# dotfiles

Personal configuration files for bash, vim, and tmux.

## What's here

- `bash_profile`, `bashrc`, `profile` — bash configuration (aliases, toolchain setup for
  Ruby/NVM/Java/Go/Docker/etc). Shared aliases and shell-tool integrations live in `common.sh`,
  sourced by `bash_profile` and `profile`.
- `starship/starship.toml` — prompt config (see below).
- `vim/vimrc` — Vim configuration (Vundle/vim-plug, Dracula theme).
- `tmux/tmux.conf` — tmux configuration.
- `welcome-terminal.txt` — ASCII banner shown on new terminal sessions.
- `install.sh` — symlinks the files above into `$HOME` for the current OS (macOS/Linux).

## Setup

### New machine (macOS)

On a fresh macOS install, run the bootstrap script:

```sh
curl -fsSL https://raw.githubusercontent.com/cstipkovic/.dotfiles/master/install_my_env.sh | bash
```

It installs Xcode Command Line Tools and Homebrew if missing, runs the Homebrew bundle, clones this
repo, runs `install.sh`, installs the Vim plugins and switches the login shell to bash (asking for
your password). At the end it prints the remaining manual steps (App Store/Bitwarden login, `gh auth
login`, git identity, SSH key, `secrets.env`, app accounts).

### Existing machine

Clone the repo to `~/.dotfiles` and run the installer:

```sh
git clone https://github.com/cstipkovic/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

These dotfiles configure **bash**. macOS defaults to zsh, so make bash your login shell and open a
new Terminal window afterwards:

```sh
chsh -s /bin/bash
echo $SHELL   # should print /bin/bash
```

The installer backs up any existing `~/.bashrc`, `~/.common.sh`, `~/.vimrc`, `~/.tmux.conf`,
`~/.bash_profile`, `~/.config/starship.toml`, etc. to `<file>.bak-<timestamp>` before creating the
symlinks. It is safe to run more than once. Vim plugins are installed separately with
`vim +PlugInstall +qa`.

### Shell tools

`common.sh` is linked to `~/.common.sh` and sourced by `bash_profile`, `bashrc` and `profile`, so both
login and non-login shells get the same setup. It wires in a few external tools if they're installed
(each check is a no-op otherwise, so the shell still works fine without them):

- [starship](https://starship.rs) — prompt, configured via `starship/starship.toml`
- [fzf](https://github.com/junegunn/fzf) — fuzzy history (`Ctrl+R`), file (`Ctrl+T`) and
  directory (`Alt+C`) search
- [zoxide](https://github.com/ajeetdsouza/zoxide) — smarter `cd` (`z <term>`)
- [direnv](https://direnv.net) — per-directory environment variables

Install them with Homebrew: `brew install starship fzf zoxide direnv tmux`.

### Vim plugins

The installer already downloads [vim-plug](https://github.com/junegunn/vim-plug) to
`~/.vim/autoload/plug.vim`. Install the plugins declared in `vim/vimrc` with:

```sh
vim +PlugInstall +qa
```

The `vim-prettier` plugin runs `yarn install` as a post-install hook, so `yarn` must be on `PATH`
(`brew install yarn`). If it was missing, install it and run the hook again:

```sh
cd ~/.vim/plugged/vim-prettier && yarn install --frozen-lockfile --production
```

### Secrets

API keys and tokens (e.g. `GEMINI_API_KEY`, `GITHUB_PERSONAL_ACCESS_TOKEN`) are **not** stored in
this repo. Create `secrets.env` next to this README (`~/.dotfiles/secrets.env`) with your own
`export VAR="value"` lines; `common.sh` sources it if present and it's git-ignored.

### Welcome banner

```sh
figlet -w 200 -f small -k "Zdravo,  Mr.  Stipkovic" > ~/.dotfiles/welcome-terminal.txt
```
