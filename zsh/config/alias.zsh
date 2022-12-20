#builtin replace
alias cat='bat'
alias diff='delta'
alias du='dua i'
alias find='fd'
alias grep='rg'
alias rm='trash-put'
alias top='btm'
alias ls='lsd'
alias cd='z'

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
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
alias lr='lsd -tlR'

# use eva to make computation
alias calc='eva'

# vim alias
alias vim='nvim'
alias vi='nvim'
alias e='{{editor}}'

# go to config
alias config='cd ~/dotfiles/ && {{editor}} . && dotter'

# upgrade system
alias upgrade='topgrade'

# clipboard alias
alias wgetclip='wget $(wl-paste)'
alias gcloneclip='git clone $(wl-paste)'

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

# dotter
alias dotter='dotter -v'

# sway
alias sway_find='swaymsg -t get_tree | grep'

# python
alias pip='python -m pip'
alias -s py='python'

# suffix alias
alias -s pdf='{{pdf-reader}}'
alias -s html='{{browser}}'

alias -s zip='unzip -l'
alias -s rar='unrar -l'
alias -s tar='tar tf'
alias -s tar.gz='echo'

