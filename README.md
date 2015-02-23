This contains the project files for a Workshop on Clojure + [YesQL][0].


Virtual Machine Provisioning
----------------------------

To get started, download [VirtualBox][1] and [Vagrant][2], and use
them to stand up a Ubuntu 14.10 virtual machine with all the goodies
installed and configured (see the `Vagrantfile` if you want to run the
previsioning process locally.

    vagrant up

Once it has downloaded and initialized the virtual machine, you can
connect to it:

    vagrant ssh

*Note:*: I actually find it easier to run the following:

    vagrant ssh-config >> $HOME/.ssh/config

As then I can `ssh yesql` directly.


  [1]: https://www.virtualbox.org/
  [2]: https://www.vagrantup.com/
  [0]: https://github.com/krisajenkins/yesql


Workshop Source Code
--------------------

The project is located in the `yesql-xp` directory, and follow along
with the instructions at [this site][3].


  [3]: https://fitacular.com/blog/clojure/web/2014/07/25/clojure-migration-examples/
