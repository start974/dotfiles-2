#!/bin/sh
set -xe

{{#if install_pkgs}}
pamac install {{#each arch_pkgs }} "{{this}}" {{/each}}

{{#each cargo_pkgs }}
cargo install {{this}}
{{/each }}

{{/if}}

#omz update
{{#if not(is_executable omz)}}
echo isntall "omyzsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
{{/if}}
