#!/bin/sh
set -ex

{{#if update_pkgs}}
    echo "update all"

    git submodule update

    {{sys_update}}

{{/if}}

{{#if install_pkgs}}

# install omz
    {{#if not(is_executable omz)}}
        #omz update
        echo "install omyzsh"
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    {{/if}}

# install cargo
    {{#if not(is_executable cargo)}}
        curl https://sh.rustup.rs -sSf | sh
    {{/if}}

# install packages

    {{sys_install}} {{#each sys_pkgs }} "{{this}}" {{/each}}

    cargo install {{#each pkgs.cargo }} "{{this}}" {{/each }}

    python3 -m pip install {{#each pkgs.pip }} "{{this}}" {{/each }}



{{/if}}
