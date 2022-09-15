#!/bin/sh -xe
install_arch () {
    echo "===== $1 ====="
    pamac install "$1"
}

install_aur () {
    echo "===== $1 ====="
    paru -S "$1"
}

install_cargo () {
    echo "===== $1 ====="
    cargo install $1
}

install_arch rust

install_arch git

install_arch neovim

# rust efficent package
install_arch git-delta
install_cargo bat
