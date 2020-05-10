#!/bin/bash

echo "Install Yarn using NVM without install node again"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install --no-install-recommends yarn
tee -a $HOME/.zshrc << END
# Yarn
export PATH="\$PATH:\$HOME/.yarn/bin"
END
echo "Reload ZSHRC"
source ~/.zshrc
echo "Yarn Version"
yarn --version
echo "Done"
