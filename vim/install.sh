#!/bin/sh

# Vundle bundle manager for vim.
vim_home="$HOME/.vim"
if [ ! -d "$vim_home/bundle/vundle" ]; then
    echo "Downloading Vundle [vim bundle manager] ..."
    git clone git://github.com/gmarik/Vundle.vim.git "$HOME/.vim/bundle/vundle"
fi

exit 0;
