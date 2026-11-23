# fix editor
export EDITOR={{editor}}

# history
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="dd/mm/yyyy"

export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# update oh-my-zsh automatically without asking
zstyle ':omz:update' mode auto

# auto suggestion
ZSH_AUTOSUGGEST_STRATEGY=("history" "completion")
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#696969"

# zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# application on path and init
addPath (){
    export PATH="$PATH:$(realpath $1)"
}
# to append path
addPath "{{script_dir}}"

# to append path
addPath "$HOME/.local/bin"
addPath "$HOME/bin"
addPath "$HOME/.opencode/bin"

{{#if (is_executable "cargo")}}
# cargo
addPath "$HOME/.cargo/bin/"
{{/if}}

{{#if (is_executable "snap")}}
# snap
addPath "/snap/bin/"
{{/if}}
