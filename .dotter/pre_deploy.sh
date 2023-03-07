#!/bin/sh
set -e

{{#if update_pkgs}}
    echo "update all"
    git submodule update
    {{pm_update}}
{{/if}}

{{#if install_pkgs}}

    {{pm_install}} {{#each pkgs }} "{{this}}" {{/each}}


    cargo install {{#each cargo_pkgs }}{{this}}{{/each }}

    pip install {{#each pip_pkgs }} {{this}} {{/each }}

    sudo npm i -g {{#each npm_pkgs }} {{this}} {{/each }}

    {{#if not(is_executable omz)}}
        #omz update
        echo "install omyzsh"
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    {{/if}}

{{/if}}
