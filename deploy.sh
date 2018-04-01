#!/run/current-system/sw/bin/bash
#sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
#sudo nix-channel --update unstable

PWD="$(pwd)"

export NIX_PATH="custompkgs=${PWD}/nix/default.nix:$NIX_PATH"

# Link nixos configuration
NIXOS_SRC="${PWD}/nixos"
NIXOS_DEST="/etc/nixos"

sudo rm -rf "${NIXOS_DEST}/config" "${NIXOS_DEST}/configuration.nix"
sudo ln -s "${NIXOS_SRC}/config" "${NIXOS_DEST}/config"
sudo ln -f "${NIXOS_SRC}/configuration.nix" "${NIXOS_DEST}/configuration.nix"

stow -d dotfiles -t ~  X zsh editor screenlayout i3 git mutt


# Use lxappearance to choose a theme
