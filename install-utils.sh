#!/bin/bash

read -p "Wich languages do you want to install? (separate by comma): " languages
languages=${languages//,/ }

asdf_install() {
    asdf plugin-add "$1"
    asdf install "$1" latest
    asdf global "$1" latest
}

install_dependencies() {
    sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses-dev libffi-dev libgdbm-dev gcc g++ make libpq-dev -y
}

install_dependencies
for language in $languages; do
    echo "Installing $language"
    asdf plugin-add "$language"
    read -p "Do you want to set the version of $language? (y/n): " answer
    if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
        if [ "$language" == "ruby" ]; then
            asdf_install "$language"
            gem install bundler
            gem install
        fi

        if [ "$language" == "node" ]; then
            asdf_install "$language"
            sudo npm install yarn -g
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

read -p "Do you want to install LunarVim? [y/n]: " LunarVim
if [ "$LunarVim" == "y" ]; then
    sudo apt install -y ./nvim-linux64.deb
    bash <(sudo curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
    export PATH=~/.local/bin:$PATH
    echo "Installed LunarVim successfully"

fi

read -p "Do you want to fetch the repositories? [y/n]: " fetchRepos
if [ "$fetchRepos" == "y" ]; then
    ./fetch-repos.sh
fi

read -p "Do you want to install postgresql? [y/n]: " installPostgres
if [ "$installPostgres" == "y" ]; then
    sudo apt install -y postgresql postgresql-contrib -y
    sudo -i -u postgres
    createuser -s postgres
    psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';"
fi