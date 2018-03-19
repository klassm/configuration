#!/run/current-system/sw/bin/bash
PWD="$(pwd)"

# Link nixos configuration
NIXOS_SRC="${PWD}/nixos"
NIXOS_DEST="/etc/nixos"

sudo rm -f "${NIXOS_DEST}/config" "${NIXOS_DEST}/configuration.nix"
sudo ln -s "${NIXOS_SRC}/config" "${NIXOS_DEST}/config"
sudo ln -f "${NIXOS_SRC}/configuration.nix" "${NIXOS_DEST}/configuration.nix"

stow -d dotfiles -t ~  X zsh vim screenlayout i3 git


# Use lxappearance to choose a theme
