#!/bin/bash -i

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-contrib/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations, 
# and if missing - will download a temporary copy that automatically get deleted at the end 
# of the script
ensure_nanolayer nanolayer_location "v0.4.45"


${nanolayer_location} \
    install \
    devcontainer-feature \
    "ghcr.io/chalk-hwang/devcontainers/features/asdf:1" \
    --option plugin='direnv' --option version="${VERSION}"
    



if [[ "$(cat /etc/bash.bashrc)" != *"$1"* ]]; then
    asdf direnv setup --shell zsh --version $VERSION
fi
if [ -f "/etc/zsh/zshrc" ] && [[ "$(cat /etc/zsh/zshrc)" != *"$1"* ]]; then
    asdf direnv setup --shell zsh --version $VERSION
fi

updaterc() {
}
echo 'Done!'
