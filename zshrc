export ZSH=~/.oh-my-zsh

# ZSH_THEME="awesomepanda"
ZSH_THEME="random"
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
plugins=(git)
#plugins=(zsh-autosuggestions)

export PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/aws/bin:/home/kishinao/.local/bin:/home/kishinao/bin:/opt/aws/bin:/home/kishinao/bin:/opt/aws/bin"

# anyenv
if [ -d $HOME/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init - zsh)"
fi

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source $ZSH/oh-my-zsh.sh
fi

# peco setting
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
if [ ${commands[peco]} ] ; then
  zle -N peco-select-history
  bindkey '^r' peco-select-history
fi

# ヒストリ(履歴)を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 256color
export TERM=xterm-256color

# brew bundle
alias ebb='vim ~/dotfiles/mac/Brewfile'
alias rbb='cd ~/dotfiles/mac && brew bundle'

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# ghq
alias g='cd $(ghq root)/$(ghq list | peco)'

# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias refresh='source ~/.zshrc'

# Terraform
alias tf='terraform'
alias tfinit='terraform init'
alias tffmt='terraform fmt'
alias tfplan='terraform plan'

# lazy*
alias lzd='lazydocker'
alias ldg='lazygit'

# docker
alias d='docker'
alias dc='docker-compose'
alias be2e='docker exec -it ldat-unit bucky run -t e2e -d'
alias blink='docker exec -it ldat-unit bucky run -t linkstatus -d'
alias bc='docker exec -it ldat-unit bucky run -t e2e -d -c'
