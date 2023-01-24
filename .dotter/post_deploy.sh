#!/bin/sh
set -e

# reload sway
{{#if dotter.packages.sway}}
echo "reload sway"
sway reload &> /dev/null
{{/if}}

# reload tmux
{{#if dotter.packages.tmux}}
echo "reload tmux"
 tmux source-file ~/.tmux.conf
{{/if}}
