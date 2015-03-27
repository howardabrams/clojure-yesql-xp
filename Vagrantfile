# -*- mode: ruby -*-
# vi: set ft=ruby :

# -----------------------------------------------------------
# Virtual Machine Configuration for YesQL Workshop
# -----------------------------------------------------------

# The following is the provisioning script that gets executed to set everything.

Vagrant.configure("2") do |config|

  # The following starts up an Ubuntu Virtual Machine and sets up the
  # fun for playing with Clojure and YesQL as well as a Postgresql
  # system for testing.

  config.vm.define :yesql do |node|

    # Every Vagrant virtual environment requires a box to build off of.
    node.vm.hostname = "yesql"
    node.vm.box = "trusty64"
    node.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
#    node.vm.box = "utopic64"
#    node.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/utopic/current/utopic-server-cloudimg-amd64-vagrant-disk1.box"

    node.vm.network :private_network, ip: "172.16.0.10"
    node.vm.synced_folder ".", "/vagrant"

    # Server port forwarding ... this may be optional for this project
    config.vm.network :forwarded_port, guest: 4242, host: 4242 # nrepl
    config.vm.network :forwarded_port, guest: 4343, host: 4343 # browser

    config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end

    config.vm.provision :shell, inline: "apt-get update"
    config.vm.provision :shell, inline: "apt-get install -y wget unzip tmux"

    # Install Java and then use a script to install Leiningen and Clojure:
    config.vm.provision :shell, inline: "apt-get install -y openjdk-7-jdk"
    config.vm.provision :shell, inline: "su vagrant -c /vagrant/Vagrantboot/bootstrap-clojure.sh"

    # Install and configure MySQL and a data set with these scripts:
    config.vm.provision :shell, path:   "Vagrantboot/bootstrap-mysql.sh"
    config.vm.provision :shell, path:   "Vagrantboot/import-dataset.sh"
  end

end
