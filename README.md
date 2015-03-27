This contains the project files for a Workshop on Clojure + [YesQL][0].

This workshop assumes that you know the basics of Clojure as well as
having a functional environment for writing Clojure. If you would like
an introduction to Clojure, please see the Clojure Bridge worksheets
or one of the many good books on the subject.


Virtual Machine Provisioning
----------------------------

To get started, download [VirtualBox][1] and [Vagrant][2], and use
them to stand up a Ubuntu 14.10 virtual machine with all the goodies
installed and configured (see the `Vagrantfile` if you want to run the
previsioning process locally).  The provisioning process installs
MySQL and a running Clojure world.

If you are attending the mini-workshop, please run `vagrant up` prior
to the meeting (which can take up to an hour). When you arrive at the
workshop run the `go` script.

The `go` script brings up the virtual machine (essentially, `vagrant
up`) and then connects to it and starts up a `tmux` section with
clients to everything.

*Note:*: I actually find it helpful to run the following:

    vagrant ssh-config >> $HOME/.ssh/config

As then I can `ssh yesql` directly.


  [1]: https://www.virtualbox.org/
  [2]: https://www.vagrantup.com/
  [0]: https://github.com/krisajenkins/yesql


Downloading a Data Set
----------------------

In order to really explore what can be done through the YesQL
interface, we need a data set. Preferably one that is:

  * Small
  * Multi-table
  * Interesting

Which is a pretty tall order. Here is the locations of some ideas:

  * http://deeplearning.net/datasets/
  * https://data.sfgov.org/data?category=Energy%20and%20Environment
  * http://mldata.org/
  * https://www.civicapps.org/ (need to register to download this Portland City data sets
  * https://aws.amazon.com/public-data-sets/ consists of huge, E2-specific datasets. Not really an option for this project.

The following are particular data sets that have potential:

  * Wind Data: https://data.sfgov.org/Energy-and-Environment/San-Francisco-Wind-Monitoring-Data-Current/bkgs-xaqe
  * Bird Identification: http://ebird.org/ebird/data/download
  * County Business Census: https://www.census.gov/econ/cbp/download/
  * Book Reviews: http://www2.informatik.uni-freiburg.de/~cziegler/BX/

In the end, this last Book Review project includes 3 tables in SQL
format that is directly downloadable, so that is the winner for this
project.  See the `Vagrantboot/import-dataset.sh` script for
downloading and installing this dataset.


Workshop Source Code
--------------------

The project is located in the `yesql-xp` directory, and follow along
with the instructions at [this site][3].

The `go` script starts a headless REPL from this directory and opens
it to port 4242. Which means, you can have Emacs Cider connect to it
with:   `M-x cider-connect`
And supply that with `localhost` and port `4242`.

The SQL query files should go in:

The code should connect to the database using this code:

(def db-spec {:classname "mysql.mysql-connector-java"
              :subprotocol "mysql"
              :subname "//localhost:5432/demo"
              :user "root" :password "byebye"})


  [3]: https://fitacular.com/blog/clojure/web/2014/07/25/clojure-migration-examples/
  [4]: http://www.luminusweb.net/docs/database.md


Developing and Forking
----------------------

This project was designed as an example for hosting mini Workshops for user groups.
Consequently, one of the goals is to keep this Git project simple, including:

  * yesql-xp ... The actual Clojure project
  * Vagrantboot ... All virtual machine
