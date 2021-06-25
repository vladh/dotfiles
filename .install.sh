#!/bin/bash
set -e

if [ ! -d ~/dotfiles ]; then
  echo "ERROR: Please clone to ~/dotfiles and then run this script."
  exit
fi

if [ "$(uname)" == "Darwin" ] && [[ $(command -v brew) == "" ]]; then
  echo "WARNING: You're on macOS but don't have Homebrew installed. It's highly recommended to install Homebrew first, otherwise you will have to install some things manually."
  echo ""
fi

echo "This will install the dotfiles in your home directory."
echo "It may override some files. It will ask you before doing so."
read -r -p "Continue? [y/N] " response
case "$response" in
  [yY][eE][sS]|[yY])
    ;;
  *)
    exit
    ;;
esac

if [ -r ~/.bashrc ]; then
  echo "Backing up ~/.bashrc to ~/.bashrc_backup."
  mv -i ~/.bashrc ~/.bashrc_backup
fi
if [ -r ~/.bash_profile ]; then
  echo "Backing up ~/.bash_profile to ~/.bash_profile_backup."
  mv -i ~/.bash_profile ~/.bash_profile_backup
fi
if [ -r ~/.gitconfig ]; then
  echo "Backing up ~/.gitconfig to ~/.gitconfig_backup."
  mv -i ~/.gitconfig ~/.gitconfig_backup
fi

# TODO: Merge ~/.config folder
echo "Moving dotfiles into your home directory."
for d in ~/dotfiles/.[^.]*/; do
  d_basename="$(basename $d)"
  mkdir -p ~/"${d_basename}"
  mv -i "${d}"/* "${d}"/.[^.]* ~/"${d_basename}/" 2>/dev/null || true
  rmdir "${d}"
done
mv -i ~/dotfiles/* ~/dotfiles/.[^.]* ~/ || true

echo "Removing ~/dotfiles folder."
rm -rf ~/dotfiles

echo "Installing vim-plug for Neovim."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ "$(uname)" == "Darwin" ]; then
  echo "macOS detected."
  if [[ $(command -v brew) == "" ]]; then
    echo "Homebrew not present. You will have to install macOS-specific packages manually. See README.md."
  else
    echo "Installing reattach-to-user-namespace."
    brew install reattach-to-user-namespace
    echo "Installing fd."
    brew install fd
  fi
else
  echo "You're not on macOS, so remember you will have to install some packages manually. See README.md."
fi

echo "Removing README.md and .install.sh."
rm ~/README.md
rm ~/.install.sh

echo "Done! Enjoy your new dotfiles. :)"
