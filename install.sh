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
install-file "xmodmap" "$HOME/.xmodmap"
install-file "xinitrc" "$HOME/.xinitrc"

if [ -e "/usr/bin/nvim" ]; then
    vimdir="$HOME/.config/nvim"
    vimrc="$vimdir/init.vim"
else
    vimdir="$HOME/.vim"
    vimrc="$HOME/.vimrc"
fi

mkdirp "$vimdir/ftplugin"
install-file "vimrc" "$vimrc"
install-file "sh.vim" "$vimdir/ftplugin/sh.vim"
install-file "javascript.vim" "$vimdir/ftplugin/javascript.vim"
install-file "json.vim" "$vimdir/ftplugin/json.vim"
install-file "python.vim" "$vimdir/ftplugin/python.vim"
install-file "vimplugins" "$vimdir/plugins.vim"
mkdirp "$HOME/.config/i3/"
install-file "i3" "$HOME/.config/i3/config"
install-file "i3lock-multimonitor" "$HOME/.config/i3/i3lock-multimonitor"
mkdirp "$HOME/.config/i3status"
install-file "i3status" "$HOME/.config/i3status/config"
vimbundle="$vimdir/bundle"

if [ ! -e "$vimbundle" ]; then
    mkdirp "$vimbundle"
    if [ $vimbundle != "$HOME/.vim/bundle" ]; then
        mkdirp "$HOME/.vim"
        if [ -e "$HOME/.vim/bundle" ]; then
            rm -rf "$HOME/.vim/bundle"
        fi
        install-raw "$vimbundle" "$HOME/.vim/bundle"
    fi

    git clone "https://github.com/VundleVim/Vundle.vim.git" "$vimbundle/Vundle.vim"
    if [ -e "/usr/bin/nvim" ]; then
        # shamelessly stolen from https://github.com/shoelick/dotfiles/blob/master/packages/neovim/neovim.sh#L78
        nvim +colorscheme default +PluginInstall +qall
    else
        vim -s "$scriptdir/install.vim"        
    fi

    if [ -d $vimbundle/youcompleteme ]; then
        cur_dir=$(pwd)
            
        cd "$vimbundle/youcompleteme"
        ./install.py --gocode-completer --tern-completer --clang-completer

        cd $cur_dir
    fi
fi

mkdirp "$HOME/.oh-my-zsh/custom/themes"
install-file "zsh-theme" "$HOME/.oh-my-zsh/custom/themes/custom.zsh-theme"
install-file "sudoers" "/etc/sudoers.d/99-keepenv"
