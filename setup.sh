#!/bin/bash

if [ -x "$(command -v zsh)" ]; then

    ## if asdf is not installed, install it

    if [ ! -d ~/.asdf ]; then
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
        echo -e "\n. $HOME/.asdf/asdf.sh" >>~/.zshrc
        echo -e "\n. $HOME/.asdf/completions/asdf.bash" >>~/.zshrc

    fi

    if [ ! -d ~/powerlevel10k ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

    fi

    cd ~ && echo 'cd ~' >>.zshrc

    sed -i 's/=(git)/=(git asdf)/g' .zshrc
else
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt-get install -y zsh

    chsh -s "$(which zsh)" -y
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y

fi

read -r -p "Wich languages do you want to install? (separate by comma): " languages
languages=${languages//,/ }

asdf_install() {
    asdf plugin-add "$1"
    asdf install "$1" latest
    asdf global "$1" latest
}

install_dependencies() {
    sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses-dev libffi-dev libgdbm-dev gcc g++ make libpq-dev build-essential libmysqlclient-dev -y
}

install_dependencies
for language in $languages; do
    echo "Installing $language"
    asdf plugin-add "$language"
    read -r -p "Do you want to set the version of $language? (y/n): " answer
    if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
        if [ "$language" == "ruby" ]; then
            asdf_install "$language"
            gem install bundler
            gem install rails
            gem install pg
        fi

        if [ "$language" == "node" ]; then
            asdf_install "$language"
            asdf install nodejs lts
            asdf global nodejs lts
            echo "Installing yarn"
            npm install yarn -g

        fi

        if [ "$language" == "python" ]; then
            asdf_install "$language"
            pip install --upgrade pip
            pip install --upgrade setuptools
            pip install --upgrade wheel
            pip install --upgrade virtualenv
        fi

        if [ "$language" == "rust" ]; then
            asdf_install "$language"
            cargo install cargo-install
        fi
    fi

    echo "Installing $language dependencies"

done

echo "Installed $languages successfully"

read -r -p "Do you want to install LunarVim? [y/n]: " LunarVim
if [ "$LunarVim" == "y" ]; then
    sudo apt install -y ./nvim-linux64.deb
    bash <(sudo curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

    echo "Installed LunarVim successfully"
    echo -e "\n export PATH=~/.local/bin:$PATH" >>~/.zshrc

fi

read -r -p "Do you want to fetch the repositories? [y/n]: " fetchRepos
if [ "$fetchRepos" == "y" ]; then
    read -r -p "Do you use Gitlab or Github?: " choice
    echo "You chose $choice"
    echo "Please enter your Personal Acces Token:"
    read -r token

    echo "Now enter your company name:"
    read -r org
    mkdir ~/"$org"

    cd ~/"$org" || exit

    if [ "$choice" == "gitlab" ]; then
        curl -i -H "PRIVATE-TOKEN: glpat-gLF3xjbTBo3LQEAx31uz" https://gitlab.com/api/v4/groups/"${org}" | grep -o 'git@[^"]*' | xargs -I {} git clone {}

    elif [ "$choice" == "github" ]; then
        curl -i -H "Authorization: token $token" https://api.github.com/orgs/"${org}"/repos | grep -o 'git@[^"]*' | xargs -I {} git clone {}
    else
        echo "For now, only gitlab and github are supported"
    fi

fi

read -r -p "Do you want to install Redis? [y/n]: " installRedis
if [ "$installRedis" == "y" ]; then
    sudo apt install redis-server -y
fi

read -r -p "Do you want to install postgresql? [y/n]: " installPostgres
if [ "$installPostgres" == "y" ]; then
    sudo apt install -y postgresql postgresql-contrib -y
    echo "Now you will run the following code"
    echo "psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'postgres'
    sudo -i -u postgres
    createuser -s postgres
    psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';"
elif [ "$installPostgres" == "n" ]; then
    echo "You will need to install postgresql manually"
fi

read -r -p "Do you want to install MariaDB? [y/n]:" installMariaDB
if [ "$installMariaDB" == "y" ]; then
    echo "If you get an error when trying to enter password, just run :"
    sudo service mysql start
    sudo apt install mariadb-server
    sudo mysql_secure_installation
fi
