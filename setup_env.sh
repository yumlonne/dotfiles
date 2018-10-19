#!/usr/bin/bash

sudo apt-get install zsh git -y
chsh /usr/bin/zsh

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# git clone ...
git clone https://github.com/yumlonne/dotfiles.git

# ln
dotfiles/link.sh
