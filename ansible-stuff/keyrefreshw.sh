#! /bin/bash

ssh-keygen -t rsa -b 4096 -f tmpkey -q -N ""
vault auth `cat root.token`
vault write secret/newgolemkey value="`cat tmpkey`"
vault write secret/newgolemkeypub value="`cat tmpkey.pub`"
vault read secret/newgolemkey
vault read secret/newgolemkeypub
rm tmpkey

# at this point, the new keys are stored. We have them in vault, and we want
# files/key.pub stored locally. This public key will go out for 
# overwrite on the managed servers. It will go in 
# /home/golem/.ssh/authorized_keys
vault read -field=value secret/newgolemkeypub > /home/vagrant/files/key.pub

# Use the ansible playbook to overwrite keys
ansible-playbook -u golem --private-key golem-key golem-key-refresh.yaml

# and now that the public key is overwritten on all servers, we can overwrite
# the private key on the local server
vault read -field=value secret/newgolemkey > /home/vagrant/golem-key

# lastly, load the newgolemkey* set as the golemkey* set for safe keeping
vault write secret/golemkey value="`vault read -field=value secret/newgolemkey`"
vault write secret/golemkeypub value="`vault read -field=value secret/newgolemkeypub`"

