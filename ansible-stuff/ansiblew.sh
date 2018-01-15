#! /bin/bash

vault read -field=value secret/golemkey > /home/vagrant/golem-key
chmod 600 golem-key

ansible -u golem --private-key golem-key -a 'echo "I worked!"' vault,webserver

rm golem-key

