#!/bin/sh
set -xe

{{#if install_pkgs}}


{{pm_install}} {{#each pkgs }} "{{this}}" {{/each}}

{{#if not(is_executable snap)}}
{{#each cargo_pkgs }}
cargo install {{this}}
{{/each }}
{{/if}}


{{#if not(is_executable omz)}}
#omz update
echo "install omyzsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
{{/if}}

# snap d
{{#if not(is_executable snap)}}
echo "install snapd"
sudo pacman -S snapd
sudo systemctl enable --now snapd.socket
{{/if}}

{{/if}}
