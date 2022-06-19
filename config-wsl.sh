#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt-get install -y zsh
chsh -s "$(which zsh)" -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
echo -e "\n. $HOME/.asdf/asdf.sh" >>~/.zshrc
echo -e "\n. $HOME/.asdf/completions/asdf.bash" >>~/.zshrc

sed -i 's/=(git)/=(git asdf)/g' .zshrc

echo 'https://www.nerdfonts.com/ para instalar uma fonte que contem simbolos, para ficar completo o visual do PowerLevel10K'
echo 'https://windowsterminalthemes.dev/ para instalar o tema do terminal do windows'
echo 'RESTART YOUR TERMINAL AND RUN INSTALL-UTILS.SH'
