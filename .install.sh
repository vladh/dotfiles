#!/bin/bash
set -e

if [ ! -d ~/dotfiles ]; then
  echo "ERROR: Please clone to ~/dotfiles and then run this script."
  exit
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

echo "Moving dotfiles into your home directory."
mv -i ~/dotfiles/* ~/dotfiles/.[^.]* ~/

echo "Removing ~/dotfiles folder."
rm -rf ~/dotfiles

if [ "$(uname)" == "Darwin" ]; then
  echo "macOS detected."
  if [[ $(command -v brew) == "" ]]; then
    echo "Homebrew not present. You will have to install macOS-specific packages manually."
  else
    echo "Installing reattach-to-user-namespace."
    brew install reattach-to-user-namespace
  fi
fi

echo "Done! Enjoy your new dotfiles. :)"
