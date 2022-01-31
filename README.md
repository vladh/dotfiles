# vladh's dotfiles

My dotfiles include configs for **neovim/vim**, **tmux** and **bash**. They work well on
both Linux and macOS. Here's a (non-exhaustive) list of features:

* Consistent color scheme across vim, tmux and bash (nord)
* neovim & vim settings which (in my opinion) improve quality of life, but are not
  overbearing
* Fuzzy finding in vim with [fzf](https://github.com/junegunn/fzf)
* Shell prompt with git branch
* Synchronised airline in vim and tmux
* Nice git aliases
* Various useful binaries
* [z.sh](https://github.com/rupa/z) to jump around directories in bash
* Logging all bash commands to `~/.logs`
* ...and a bunch of other stuff

### How to use

You should first create a fork of this repository, such that you can add your own
config files and commit the properly.

**Make sure you have backed up your existing files!** Then, run the following:

```bash
git clone https://github.com/vladh/dotfiles ~/dotfiles && ~/dotfiles/.install.sh
```

When starting vim, install your Plug packages:

```
:PlugInstall
```

Make sure to also consult `.tmux.conf` — the main thing you need to know is that the
prefix is <C-q>.

### Dependencies

You will have to install the following package manually:

* `fd` — Enables proper fuzzy finding in fzf. [Instructions here.](https://github.com/sharkdp/fd)

If you're on macOS, you'll also have to install the following package.

* `reattach-to-user-namespace` — Makes tmux open new windows in the right directory.
