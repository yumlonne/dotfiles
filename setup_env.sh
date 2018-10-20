#!/usr/bin/bash

sudo apt-get install zsh git -y
chsh /usr/bin/zsh

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# git clone ...
git clone https://github.com/yumlonne/dotfiles.git

# ln
dotfiles/link.sh
