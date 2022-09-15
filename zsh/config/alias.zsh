#builtin replace
alias cat='bat'
alias diff='delta'
alias du='dua i'
alias find='fd'
alias grep='rg'
alias rm='trash-put'
alias top='btm'
alias ls='lsd'

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

# sudo easly
alias '_'='sudo'

# lsd alias
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'

# use eva to make computation
alias calc='eva'

# vim alias
alias vim='nvim'
alias vi='nvim'
alias e='{{editor}}'

# go to config
alias config='cd ~/dotfiles/ && {{editor}} . && dotter'

# clipboard alias
alias wgetclip='wget $(wl-paste)'
alias gcloneclip='git clone $(wl-paste)'

# alias pipe
alias G='| grep'
alias H='| head'
alias L='| less'
alias T='| tail'
alias C='| wl-copy'

alias NE='2> /dev/null'
alias NUL='> /dev/null 2>&1'='| tail'

# printing path
alias pathln='echo $PATH | tr ":" "\n"'

# suffix alias
alias -s pdf='evince'
alias -s html='firefox'
alias -s py='python'
