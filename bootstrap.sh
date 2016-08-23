#!/usr/bin/env bash

# Install ansible
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update && apt-get -y upgrade
apt-get install -y ansible

# Install ansible dependencies
sudo ansible-galaxy install -r /vagrant/ansible/requirements.txt --force

# Run playbook
ansible-playbook -i /vagrant/ansible/ -u vagrant /vagrant/ansible/task.yml --connection=local --sudo -vvvv
ansible-playbook -i /vagrant/ansible/ -u vagrant /vagrant/ansible/site.yml --connection=local --sudo -vvvv

# install apache
apt-get install -y apache2

# point /var/www at /vagrant mount
if ! [ -L /var/www ]; then
  rm -rf /var/www
    ln -fs /vagrant /var/www
    fi
    
 # restart apache
 /etc/init.d/apache2 restart

