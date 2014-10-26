<div align="center">
  <img src="http://vladh.net/assets/images/projects/dotfiles.png" width="150" height="150">
</div>

# vladh's dotfiles

My dotfiles include configs for **vim**, **tmux** and **bash**. They are good for setting up Mac OS X as a development system, but work on Linux too. Here's a (non-exhaustive) list of features:

* Consistent color scheme across bash, zsh, vim etc. (custom Monokai, with alternate themes if you want them)
* Sane vim config with modern, sensible settings
* Syntax checking right inside vim with [Syntastic](https://github.com/scrooloose/syntastic)
* Fuzzy finding in vim with [ctrlp](https://github.com/kien/ctrlp.vim)
* bash & zsh prompt with git branch and time since last commit (thanks to [grb](https://github.com/garybernhardt))
* zsh [wunjo](http://www.wunjo.org/zsh-git/) support with detailed git information and assorted prompt customisations.
* Powerline in vim and tmux
* vim support for lots of web-related things (PHP, Mustache, CoffeeScript, HAML, Jade, Markdown, Mocha, rspec, Stylus…)
* Improvements to make everything work properly in Mac OS X (e.g. clipboard in vim inside tmux)
* [Bashmarks](https://github.com/huyng/bashmarks) to bookmark directories in bash

### How to use
Just clone the repo to `~/dotfiles` and copy what you need into your home directory. For example, to use everything while backing up your existing files and moving the Git repo to your home directory:

```bash
cd && git clone https://github.com/vladh/dotfiles --recursive
mkdir -p dotfiles-backup
mv .bash_profile .vimrc .vim .tmux.conf .git .gitconfig dotfiles-backup/
cd dotfiles
mv * .[^.]* ../
cd && rmdir dotfiles
```

To add any options you don't want in the repo, like your git.config email or .bash\_profile paths, make `_private` files. These will be included in your configuration but ignored by the repo. Currently supported:

* .bash_profile_private
* .vimrc_private
* .tmux.conf_private
* .gitconfig_private
* .zshrc_private

### Credits

* [The contributors](https://github.com/vladh/dotfiles/graphs/contributors)
* [Gary Bernhardt](https://github.com/garybernhardt)
* [Steve Losh](http://stevelosh.com/)

Complete credits in CREDITS.md.
