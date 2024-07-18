#builtin replacemen
{{#if (is_executable "bat")}}
alias cat='bat'
{{/if}}

{{#if (is_executable "delta")}}
alias diff='delta'
{{/if}}

{{#if (is_executable "dua")}}
alias du='dua i'
{{/if}}

{{#if (is_executable "fd")}}
alias find='fd'
{{/if}}

{{#if (is_executable "rg")}}
alias grep='rg'
{{/if}}

{{#if (is_executable "trash-put")}}
alias rm='trash-put'
{{/if}}

{{#if (is_executable "btm")}}
alias top='btm'
{{/if}}

{{#if (is_executable "lsd")}}
alias ls='lsd'
alias lt='lsd --tree'
alias lr='lsd -tlR'
{{/if}}

{{#if (is_executable "zoxide")}}
alias cd='z'
alias cdi='zi'
{{/if}}

alias make='make -j`nproc`'
alias mv='mv -i'
alias cp='cp -i'

# Move up quickly
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .5='cd ../../../..'
alias .6='cd ../../../../..'
alias .7='cd ../../../../../..'
alias .8='cd ../../../../../../..'

# mkdir
alias mkcdtmp='cd $(mktemp -d)'

# sudo easly
alias '_'='sudo'

# lsd alias
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'

# use eva to make computation
{{#if (is_executable "eva")}}
alias calc='eva'
{{/if}}

# vim alias
alias vim='nvim'
alias vi='nvim'
alias e='{{editor}}'

# go to config
alias config='cd ~/dotfiles/ && {{editor}} . && dotter'

# update config
alias conf-update='dotter -v && source ~/.config/zsh/.zshrc'

# upgrade system
alias upgrade='topgrade'

# clipboard alias
alias wgetclip='wget $(wl-paste)'
alias gcloneclip='git clone $(wl-paste)'
alias gchclip='git checkout $(wl-paste)'

# alias pipe
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g LL='2>&1 | less'
alias -g CA='2>&1 | cat -A'
alias -g T='| tail'
alias -g C='| wl-copy'

alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'='| tail'

# printing path
alias pathln='echo $PATH | tr ":" "\n"'

# sway
alias sway_find='swaymsg -t get_tree | grep'

# python
#alias pip='python -m pip'
alias -s py='python'

# suffix alias
alias -s pdf='{{pdf-reader}}'
alias -s html='{{browser}}'

alias -s zip='unzip -l'
alias -s rar='unrar -l'
alias -s tar='tar tf'
alias -s tar.gz='echo'

