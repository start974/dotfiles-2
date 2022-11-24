
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    #docker
    #pipenv
    colored-man-pages
    copyfile
    extract
    git
    gitignore
    nix-zsh-completions
    #python
    zsh-autosuggestions
    zsh-syntax-highlighting
    alias-finder
    aliases
)

source $ZSH/oh-my-zsh.sh
