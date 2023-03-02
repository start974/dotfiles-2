#!/bin/sh
set -e

{{#if update_pkgs}}
    echo "update all"
    git submodule update
    {{pm_update}}
{{/if}}

{{#if install_pkgs}}

    {{pm_install}} {{#each pkgs }} "{{this}}" {{/each}}

    {{#each cargo_pkgs }}
        cargo install {{this}}
    {{/each }}


    {{#if not(is_executable omz)}}
        #omz update
        echo "install omyzsh"
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    {{/if}}

{{/if}}
