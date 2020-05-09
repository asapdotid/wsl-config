#!/bin/bash

nvm_version=v0.35.3
node_version=12.16.3
echo "Install NVM"
curl -o nvm-install.sh https://raw.githubusercontent.com/nvm-sh/nvm/${nvm_version}/install.sh && sh nvm-install.sh;
rm -rf nvm-install.sh
tee -a $HOME/.zshrc << END
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
END
echo "Reload ZSHRC"
source ~/.zshrc
echo "NVM Version"
nvm --version
echo "Install latest Node JS LTS"
nvm install ${node_version}
nvm alias default ${node_version}
echo "Node Version"
node -v
echo "Done"
