#!/bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdirp() {
    if [ -e "$1" ]; then
        if [ ! -d "$1" ]; then
            echo "!! '$1' exists but is not a directory !!"
            exit 1
        fi
    else
        echo "** Creating directory '$1'"
    fi
    mkdir -p $1
}

install-raw() {
    abs_source="$(readlink -f $1)"
    if [ -e $2 ]; then
        abs_target="$(readlink -f $2)"
        if [ "$abs_source" == "$abs_target" ]; then
            return # nothing to do
        fi
    fi
    echo "** Linking '$2' to '$1'"
    ln --backup=numbered --suffix="" -vrs "$1" "$2"
}

install-file() {
    install-raw "$scriptdir/$1" "$2"
}

mkdirp "$HOME"
install-file "tmux.conf" "$HOME/.tmux.conf"
install-file "zshrc" "$HOME/.zshrc"
install-file "xresources" "$HOME/.Xresources"
install-file "latexmkrc" "$HOME/.latexmkrc"

mkdirp "$HOME/.config/nvim"
install-file "vimrc" "$HOME/.config/nvim/init.vim"
install-file "vimplugins" "$HOME/.config/nvim/plugins.vim"

vimbundle="$HOME/.config/nvim/bundle"
if [ ! -e "$vimbundle" ]; then
    mkdirp "$vimbundle"
    mkdirp "$HOME/.vim"
    if [ -e "$HOME/.vim/bundle" ]; then
        rm -rf "$HOME/.vim/bundle"
    fi
    install-raw "$vimbundle" "$HOME/.vim/bundle"
    git clone "https://github.com/VundleVim/Vundle.vim.git" "$vimbundle/Vundle.vim"
    # shamelessly stolen from https://github.com/shoelick/dotfiles/blob/master/packages/neovim/neovim.sh#L78
    nvim +colorscheme default +PluginInstall +qall

    cur_dir=$(pwd)
    
    cd "$vimbundle/youcompleteme"
    ./install.py --gocode-completer --tern-completer --clang-completer

    cd $cur_dir
fi

mkdirp "$HOME/.oh-my-zsh/custom/themes"
install-file "zsh-theme" "$HOME/.oh-my-zsh/custom/themes/custom.zsh-theme"

