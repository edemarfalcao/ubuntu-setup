#!/bin/bash

echo "Please enter your GitHub GPGKey:"
read token
echo "Now enter your organization name:"
read org
mkdir "$org"

cd "$org" || exit

curl -i -H "Authorization: token $token" https://api.github.com/orgs/"${org}"/repos | grep -o 'git@[^"]*' | xargs -I {} git clone {}
