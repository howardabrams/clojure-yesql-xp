This contains the project files for a Workshop on Clojure +
[YesQL][0].  YesQL is a way to connect your Clojure code to data
hosted in some sort of data base. To fascilitate this workshop, we
create a *virtual machine* to host the database server as well as
loading up some interesting data to use as we explore this project.

This workshop assumes that you know the basics of Clojure as well as
having a functional environment for writing Clojure. If you would like
an introduction to Clojure, please see the Clojure Bridge worksheets
or one of the many good books on the subject.


Virtual Machine Provisioning
----------------------------

To get started, download [VirtualBox][1] and [Vagrant][2], as we will
use them to stand up a Ubuntu virtual machine with all the goodies
installed and configured (see the `Vagrantfile` if you want to run the
previsioning process locally).  The provisioning process installs
MySQL and a running Clojure world.

If you are attending the mini-workshop, please run `vagrant up` prior
to the meeting (which can take up to an hour). When you arrive at the
workshop run the `go` script.

The `go` script brings up the virtual machine (essentially, `vagrant
up`) and then SSHs into the machine to start a `tmux` session with
a client to the MySQL database and a Clojure REPL.

*Note:*: I actually find it helpful to run the following:

    vagrant ssh-config >> $HOME/.ssh/config

As then I can `ssh yesql` directly.

  [1]: https://www.virtualbox.org/
  [2]: https://www.vagrantup.com/
  [0]: https://github.com/krisajenkins/yesql


Background on the Data Set
--------------------------

In order to really explore what can be done through the YesQL
interface, we need a data set. Preferably one that is:

  * Small
  * Multi-table
  * Interesting

A pretty tall order! Here are locations to site that contain ideas:

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

In the end, the **Book Review** project includes 3 tables in SQL
format that is directly downloadable, so that is the winner for this
project.  See the `Vagrantboot/import-dataset.sh` script for how we
download and install this dataset.


Developing and Forking
----------------------

This project was designed as an example for hosting mini Workshops for user groups.
Consequently, one of the goals is to keep this Git project simple, including:

  * `yesql-xp` ... The actual Clojure project
  * `go` ... The script to start the workshop project
  * `Vagrantfile` ... configuration for the virtual machine
  * `Vagrantboot` ... All virtual machine scripts needed to start


The Workshop
------------

The `go` script starts a headless REPL from this directory and opens
it to port `4242`. Which means, you can have Emacs Cider connect to it
with:   `M-x cider-connect`
And supply that with `localhost` and port `4242`.

*Note:* The Clojure project is located in the `yesql-xp` directory,
and we could follow along with instructions from [this site][3].
However, I'm thinking that for this project, we could probably figure
out how to explore it on our own.

The SQL query files for YesQL go in the `yesql-xp/resources` directory.
Create file, `book-count.sql` that contains (including the comments):

    -- Counts the number of books. Notice this uses the un-standard MySQL
    -- syntax that requires the table name to be surrounded in backquotes.

    SELECT count(*) AS count
    FROM `BX-Books`;

Assuming you can connect to the running REPL running on `localhost` on port 4242,
get the `defquery` function:

    (require '[yesql.core :refer [defquery]])

And let's associate our SQL file with a variable:

    (defquery num-books "book-count.sql")

Now `num-books` references the SQL file: `yesql-xp/resources/book-count.sql`

Typing: `(clojure.repl/doc num-books)` gets that query's documentation
(e.g. comments). Pretty nice.

To write some Clojure code to use this SQL "function" and connect to
the database to have it evaluated, edit `yesql-xp/src/yesql_xp/core.clj`
(or use the REPL), and create a *database connector specification* to
connect to our MySQL database:

    (def db-spec {:classname "com.mysql.jdbc.Driver"
                  :subprotocol "mysql"
                  :subname "//localhost:3306/bx"
                  :user "root"
                  :password "byebye"})

Now, let's call the `num-books` function. Keep in mind, the parameter
is this database connector specification is the first parameter. Any
other variables that should be substituted in the query go after this:

    (num-books db-spec)

What's next?

At this point, we should explore the database tables in the `mysql`
client (in the `tmux` session, type `Ctrl-b 1`, and use commands like
`show tables;` to get to know the schema.

Next, create SQL queries in the `yesql-xp/resources` directory. These
should work the same as the queries typed into the MySQL client REPL.

Finally, edit the `core.clj` file to see just how the YesQL interface
exposes those queries to Clojure.



  [3]: https://fitacular.com/blog/clojure/web/2014/07/25/clojure-migration-examples/
  [4]: http://www.luminusweb.net/docs/database.md
