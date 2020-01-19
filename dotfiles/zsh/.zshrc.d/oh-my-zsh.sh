export ZSH="/home/klassm/.oh-my-zsh"

ZSH_THEME="bira"
plugins=(git pyenv zsh-peco-history kubectl gulpw zsh-syntax-highlighting zsh-autosuggestions)

export ZSH_PECO_HISTORY_DEDUP=true
export ZSH_PECO_HISTORY_OPTS="--layout=bottom-up"
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

source $ZSH/oh-my-zsh.sh

