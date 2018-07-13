export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
xrandr --output eDP-1 --primary

for f in ~/.zshrc.d/*; do source $f; done
