#!/bin/bash
nvm_version=v0.35.2
node_version=12.15.0
echo "Install NVM"
curl -o- https://raw.githubusercontent.com/creationix/nvm/${nvm_version}/install.sh | bash
cat << EOF >> ~/.zshrc
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
echo "Reload ZSHRC"
source ~/.zshrc
echo "NVM Version"
nvm --version
echo "Install latest Node JS LTS"
nvm install ${node_version}
echo "Node Version"
node -v
echo "Done"
