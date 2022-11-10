#!/bin/bash

#This script is meant to be run on a Ubuntu 20.04
#It will install all required packages for a B2B project

# asdf install ruby 2.7.4
# asdf reshim ruby
# gem install mailcatcher
# gem install carrierwave
# gem install mini_magick
# gem install foreman

# sudo apt install -y imagemagick


## create a .env in each project

env_file="
MYSQL_HOST='localhost'
MYSQL_USERNAME='falcao'
MYSQL_PASSWORD='password'
MYSQL_DATABASE='b2bstack'
EMAIL_ADMIN='edemar.falcao@b2bstack.com.br
"


# cd ~/b2bstack/portal && asdf local ruby 2.7.4 && bundle install && echo "$env_file" >.env && rails db:migrate
# cd ~/b2bstack/admin && asdf local ruby 2.7.4 && bundle install && echo "$env_file" >.env && rails db:migrate
 cd ~/b2bstack/saas && asdf local ruby 2.7.4 && bundle install && echo "$env_file" >.env && rails db:migrate

# sudo mysql
# CREATE DATABASE b2bstack;
# grant all privileges on DATABASE_NAME.* TO 'falcao'@'localhost' identified by 'password'


sudo mysql -u root  b2bstack < ~/dump-b2bstack_dev23-202208241103.sql


