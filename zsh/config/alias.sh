#builtin replace
alias cat="bat"
alias diff="delta"
alias du="dua i"
alias find="fd"
alias grep="rg"
alias rm="trash-put"
alias top="btm"
alias ls="lsd"

alias make="make -j`nproc`"
alias lt="lsd --tree"

# use eva to make computation
alias calc="eva"

# vim alias
alias vim="nvim"
alias vi="nvim"
alias e="{{editor}}"

# go to config
alias config="cd ~/dotfiles/ && {{editor}} . && dotter"

# clipboard alias
alias wgetclip="wget $(clippaste)"
alias gcloneclip="git clone $(clippaste)"

# alias pipe
alias G="| grep"
alias C="| clipcopy"

# printing path
alias pathln="echo $PATH | tr ':' '\n'"

# suffix alias
alias -s pdf="evince"
alias -s html="firefox"
alias -s py="python"
