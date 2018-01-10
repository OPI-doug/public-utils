# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "fedora/26-cloud-base"
    ansible.vm.box_version = "20170705"
    ansible.vm.network "private_network", ip: "192.168.33.13"
    ansible.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    ansible.vm.provision "shell", inline: <<-SHELL
     yum update -y
     yum install ansible -y
     yum install git -y
     yum install zip -y
     yum install vim -y
     curl -s https://releases.hashicorp.com/vault/0.9.1/vault_0.9.1_linux_amd64.zip?_ga=2.233191262.1530298798.1514997912-403752314.1514997912 https://releases.hashicorp.com/vault/0.9.1/vault_0.9.1_linux_amd64.zip?_ga=2.233191262.1530298798.1514997912-403752314.1514997912 > /vault.zip
     cd /
     unzip vault.zip
     mv vault /bin/vault
     rm vault.zip
     mkdir /src
     cd /src
     git clone https://github.com/OPI-doug/public-utils.git
     cd public-utils
     cp stupid /home/vagrant/golem-key
     chmod 600 /home/vagrant/golem-key
     chown vagrant:vagrant /home/vagrant/golem-key
     cp ansible-stuff/hosts /etc/ansible/hosts
     echo "export VAULT_ADDR=http://192.168.33.12:8200" >> /etc/bashrc
     mkdir /home/vagrant/files
     chmod 755 /home/vagrant/files
     chown vagrant:vagrant /home/vagrant/files
     cp ansible-stuff/golem-key-refresh.yaml /home/vagrant/golem-key-refresh.yaml
     chmod 644 /home/vagrant/golem-key-refresh.yaml
     chown vagrant:vagrant /home/vagrant/golem-key-refresh.yaml
     cp ansible-stuff/vaultinit.sh /home/vagrant/vaultinit.sh
     chmod 755 /home/vagrant/vaultinit.sh
     chown vagrant:vagrant /home/vagrant/vaultinit.sh
     cp ansible-stuff/ansiblew.sh /home/vagrant/ansiblew.sh
     chmod 755 /home/vagrant/ansiblew.sh
     chown vagrant:vagrant /home/vagrant/ansiblew.sh
     cp ansible-stuff/keyrefreshw.sh /home/vagrant/keyrefreshw.sh
     chmod 755 /home/vagrant/keyrefreshw.sh
     chown vagrant:vagrant /home/vagrant/keyrefreshw.sh
     cp ansible-stuff/sshconfig /home/vagrant/.ssh/config
     chmod 600 /home/vagrant/.ssh/config
     chown vagrant:vagrant /home/vagrant/.ssh/config
    SHELL
  end

  config.vm.define "vault" do |vault|
    vault.vm.box = "fedora/26-cloud-base"
    vault.vm.box_version = "20170705"
    vault.vm.network "private_network", ip: "192.168.33.12"
    vault.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    vault.vm.provision "shell", inline: <<-SHELL
     yum update -y
     yum install zip -y
     yum install python -y
     yum install git -y
     yum install libselinux-python -y
     adduser golem
     curl -s https://releases.hashicorp.com/vault/0.9.1/vault_0.9.1_linux_amd64.zip?_ga=2.233191262.1530298798.1514997912-403752314.1514997912 https://releases.hashicorp.com/vault/0.9.1/vault_0.9.1_linux_amd64.zip?_ga=2.233191262.1530298798.1514997912-403752314.1514997912 > /vault.zip
     cd /
     unzip vault.zip
     mv vault /bin/vault
     rm vault.zip
     echo "golem   ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
     mkdir /home/golem/.ssh/
     chmod 700 /home/golem/.ssh/
     chown golem:golem /home/golem/.ssh/
     mkdir /src
     cd /src
     git clone https://github.com/OPI-doug/public-utils.git
     cd public-utils
     cp stupid.pub /home/golem/.ssh/authorized_keys
     chmod 600 /home/golem/.ssh/authorized_keys
     chown golem:golem /home/golem/.ssh/authorized_keys
     cp vault-stuff/vault.service /etc/systemd/system/vault.service
     mkdir /etc/vault.d/
     cp vault-stuff/vconf.conf /etc/vault.d/vconf.conf
     systemctl daemon-reload
     systemctl start vault
    SHELL
  end

  config.vm.define "webserver" do |webserver|
    webserver.vm.box = "fedora/26-cloud-base"
    webserver.vm.box_version = "20170705"
    webserver.vm.network "forwarded_port", guest: 80, host: 8080
    webserver.vm.network "private_network", ip: "192.168.33.14"
    webserver.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    webserver.vm.provision "shell", inline: <<-SHELL
     yum update -y
     yum install python -y
     yum install httpd -y
     yum install git -y
     yum install libselinux-python -y
     adduser golem
     echo "golem   ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
     mkdir /home/golem/.ssh/
     chmod 700 /home/golem/.ssh/
     chown golem:golem /home/golem/.ssh/
     systemctl enable httpd
     systemctl start httpd
     mkdir /src
     cd /src
     git clone https://github.com/OPI-doug/public-utils.git
     cd public-utils
     cp stupid.pub /home/golem/.ssh/authorized_keys
     chmod 600 /home/golem/.ssh/authorized_keys
     chown golem:golem /home/golem/.ssh/authorized_keys
    SHELL
  end
end
