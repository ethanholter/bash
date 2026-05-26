#! /usr/bin/env bash

set -euo pipefail

install_config() {
    local src="${HOME}/${1}"
    local dest="${HOME}/${2}"

    if [ -L "$dest" ]; then
        echo "${dest} already linked. Skipping..."
        return 0
    fi

    if [ -e "$dest" ]; then
        mv "$dest" "${dest}.bak"
        echo "Backed up existing file: ${dest} -> ${dest}.bak"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "Linked: ${dest} -> ${src}"
}

install_repo() {
    local url="$1"
    local dest="${HOME}/${2}"

    if [ ! -d "$dest" ]; then
        echo "Existing config not found. Cloning {$url} to {$dest}"
        git clone "$url" "$dest"
    else
        echo "Config already cloned. Pulling from remote"
        (cd "$dest" && git pull)
    fi
}

install_repo "https://github.com/ethanholter/bash" ".config/bash"
install_config ".config/bash/.bashrc" ".bashrc"
install_config ".config/bash/.bash_profile" ".bash_profile"
install_config ".config/bash/.profile" ".profile"

echo "success"

