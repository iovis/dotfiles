#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables

dir=~/.dotfiles
olddir=~/dotfiles_old
files=".zshrc .vimrc .vim .tmux.conf .gitignore_global .gitconfig .tern-config .ctags .agignore .pryrc"
config_files=""

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -snf $dir/$file ~/$file
done

# Neovim
# mkdir ~/.config
# ln -s ~/.dotfiles/.vim ~/.config/nvim
# ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
