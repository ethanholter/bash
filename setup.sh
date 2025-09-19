#! /usr/bin/env bash
set -euo pipefail

# clone/pull config from github
if [ ! -d "${HOME}/.config/bash" ]; then
    git clone https://github.com/ethanholter/bash "${HOME}/.config/bash"
else
    (cd ${HOME}/.config/bash && git pull)
fi

# symlink already exists
if [ -L "${HOME}/.bashrc" ]; then 
    echo "Config already in use. Updated from remote"
    exit 0
fi

# regular config already exists. Make a backup
if [ -f "${HOME}/.bashrc" ]; then
    mv "${HOME}/.bashrc" "${HOME}/.bashrc.old" 
fi

# symlink config
ln -s "${HOME}/.config/bash/.bashrc" "${HOME}/.bashrc"

echo "success"

