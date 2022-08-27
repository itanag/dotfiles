#! /usr/bin/env bash

set -e
set -x

ETC=~/.local/etc
BIN=~/.local/bin
mkdir -p $ETC
mkdir -p $BIN

# git clone respository
cd ~/.local/
if [ -d dotfiles ]; then
    cd dotfiles
    git pull
else
    git clone https://github.com/itanag/dotfiles.git
    cd dotfiles
fi
cp -rf etc/* $ETC/
cp -rf bin/* $BIN/
cp bootstrap.sh $BIN/


# source init.sh
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.local/etc/base_profile" ]; then
        sed -i "\:$ETC/base_profile:d" ~/.bashrc
        echo "source $ETC/base_profile" >> ~/.bashrc
        ~/.bashrc
    fi
elif [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.local/etc/base_profile" ]; then
        sed -i "\:$ETC/base_profile:d" ~/.zshrc
        echo "$ETC/base_profile" >> ~/.zshrc
        ~/.zshrc
    fi
fi


# source vimrc.vim
touch ~/.vimrc
sed -i "\:$ETC/vimrc:d" ~/.vimrc
echo "source $ETC/vimrc" >> ~/.vimrc


# update git config
git config --global color.status auto
git config --global color.diff auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global core.quotepath false

