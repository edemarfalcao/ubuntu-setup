#!/bin/bash
# Fetch all repos from a given company

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
