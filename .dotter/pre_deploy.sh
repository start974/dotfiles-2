#!/bin/sh
set -xe

{{#if install_pkgs}}
pamac install {{#each arch_pkgs }} "{{this}}" {{/each}}

{{#each cargo_pkgs }}
cargo install {{this}}
{{/each }}

{{/if}}
