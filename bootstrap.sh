#!/bin/bash

if [ -x "$(command -v apt-get)" ]; then 
    sudo apt-get update
    sudo apt-get -y install ansible git sshpass
else
    echo Not sure which package manager is running on this machine, its not apt-get as expected
    exit 1
fi

#clone from GIT
#TODO - Remove branch reference before main branch merge
git clone -b debian-13 https://github.com/billwheatley/provision-family-desktop.git

# Make sure plain 'python' is in path (ansible does not do will without it)
if [ ! `which python` ]; then
  PYTHON3_LOC=$(which python3)
  PYTHON_LOC=$(dirname $PYTHON3_LOC)/python
  echo Need to Link $PYTHON3_LOC $PYTHON_LOC [using sudo]
  sudo ln -s $PYTHON3_LOC $PYTHON_LOC
fi

# Make Roles-dir
mkdir desktop-roles

#Call key setup playbook
PRIMARY_USER_GROUP=`id -gn`
cd provision-family-desktop

#Need sudo on open-mandriva because facts plugin needs it
sudo ansible-playbook key-setup.yaml --extra-vars="localhost_user=${USER} localhost_user_group=${PRIMARY_USER_GROUP} ansible_user_dir=${HOME}"

