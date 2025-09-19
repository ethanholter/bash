#! /usr/bin/env bash
set -euo pipefail

if [ -f "${HOME}/.bashrc" ]; then
    mv "${HOME}/.bashrc" "${HOME}/.bashrc.old" 
fi

if [ ! -d "${HOME}/.config/bash" ]; then
    git clone https://github.com/ethanholter/bash "${HOME}/.config/bash"
else
    (cd ${HOME}/.config/bash && git pull)
fi

if [ ! -f "${HOME}/.bashrc" ]; then
    ln -s "${HOME}/.config/bash/.bashrc" "${HOME}/.bashrc"
fi

echo "success"

