export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
lazy_source () {
    eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}

for f in ~/.zshrc.d/*; do source $f; done

[ -f ~/.fzf.zsh ] && lazy_source ~/.fzf.zsh
