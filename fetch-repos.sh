#!/bin/bash 

echo "Please enter your GitHub GPGKey:"
read token
token=$token
echo "Now enter your organization name:"
read org
org=$org


mkdir $org

cd $org

curl -i -H "Authorization: token $token" https://api.github.com/orgs/${org}/repos | grep -o 'git@[^"]*' | xargs -I {} git clone {}
