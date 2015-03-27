#!/bin/sh

vagrant up &&
    vagrant ssh --command "/vagrant/Vagrantboot/profile"

# Note: When this is available, you can connect with:
#   (cider-connect "172.16.0.10" 4242)
#   (cider-connect "localhost" 4242)
