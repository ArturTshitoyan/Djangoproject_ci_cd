#!/bin/bash

# Enter to terraform directory

cd teraform/

if [[ $? != 0 ]]
then
exit 1 && echo "something went wrong while entering to terraform directory"
fi

# initialize terraform backend 

terraform init

if [[ $? != 0 ]]
then
exit 1 && echo "something went wrong while initializing terraform backend"
fi

# Create infrastructure

terraform apply -auto-approve

if [[ $? != 0 ]]
then
exit 1 echo "something went wrong while creating infrastructure"
fi

# Pass Ops instance public ip to ansible inventori

echo -e "[aws]\n$(terraform output | grep ip | cut -d '"' -f 2)" > ../ansible/inventory.ini

if [[ $? != 0 ]]
then
exit 1 && echo "something went wrong while passing Ops instance public ip to ansible inventori"
fi

# Enter to ansible directory

cd ../ansible/

if [[ $? != 0 ]]
then
exit 1 && echo "something went wrong while entering to ansible directory"
fi

# Configure Ops server and install nessessary programs

ansible-playbook config_playbook.yaml -e github_token=$(cat ./github_token.txt)

if [[ $? != 0 ]]
then
exit 1 && echo "something went wrong while configuring Ops server and install nessessary programs"
fi
