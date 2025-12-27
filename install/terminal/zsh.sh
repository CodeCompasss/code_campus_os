#!/usr/bin/env bash

# install packages
sudo apt update
sudo apt install -y zsh git curl

# install oh my zsh
RUNZSH=no CHSH=no sh -c \
"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install powerlevel10k
git clone https://github.com/romkatv/powerlevel10k.git \
~/.oh-my-zsh/custom/themes/powerlevel10k

# install antigen
mkdir -p ~/.local/bin
curl -L git.io/antigen > ~/.local/bin/antigen.zsh
chmod +x ~/.local/bin/antigen.zsh

# minimal zshrc
cat <<'EOF' > ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

source ~/.local/bin/antigen.zsh
antigen use oh-my-zsh
antigen bundle romkatv/powerlevel10k
antigen apply
EOF

# set default shell
chsh -s $(which zsh)

echo "Done. Log out and log back in."
