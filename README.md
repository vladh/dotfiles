# vladh's dotfiles

My dotfiles include configs for **neovim/vim**, **tmux** and **bash**. They work well on
both Linux and macOS. Here's a (non-exhaustive) list of features:

* Consistent color scheme across vim, tmux and bash (nord)
* neovim & vim settings which (in my opinion) improve quality of life, but are not
  overbearing
* Fuzzy finding in vim with [fzf](https://github.com/junegunn/fzf)
* bash prompt with git branch
* Synchronised airline in vim and tmux
* Improvements to make everything work properly in macOS (e.g. clipboard in vim inside
  tmux)
* [z.sh](https://github.com/rupa/z) to jump around directories in bash
* Logging all bash commands to `~/.logs`

### How to use

**Make sure you have backed up your existing files!** Then, run the following:

```bash
git clone https://github.com/vladh/dotfiles ~/dotfiles && ~/dotfiles/.install.sh
```

When starting vim, install your Plug packages:

```
:PlugInstall
```

You might want to edit the `.vimrc` to enable/disable ALE/`coc.nvim`.

Make sure to also consult `.tmux.conf` — the main thing you need to know is that the
prefix is <C-q>.

### Non-macOS manual install steps

If you're not on macOS, you will have to install the following packages manually:

* `fd` — Enables proper fuzzy finding in fzf. [Instructions here.](https://github.com/sharkdp/fd)

### macOS specific packages

If you have Homebrew, the following packages will be installed automatically:

* `reattach-to-user-namespace` — Makes tmux open new windows in the right directory.
* `fd` — Enables proper fuzzy finding in fzf.

If you don't have Homebrew, you will have to install these manually. It's highly
recommended to install Homebrew before installing the dotfiles, though.

### Private files

To add any options you don't want to accidentally commit to the repo, like your git.config
email or .bash\_profile paths, make `_private` files. These will be included in your
configuration but ignored by the repo. Currently supported:

* .bash_profile_private
* .vimrc_private
* .tmux_private.conf
* .gitconfig_private

### Credits

* [The contributors](https://github.com/vladh/dotfiles/graphs/contributors)
* [Gary Bernhardt](https://github.com/garybernhardt)
* [Steve Losh](http://stevelosh.com/)
