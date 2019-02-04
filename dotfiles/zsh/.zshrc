export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
xrandr --output eDP1 --primary

for f in ~/.zshrc.d/*; do source $f; done
