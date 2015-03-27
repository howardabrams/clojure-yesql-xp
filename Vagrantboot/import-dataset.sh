#!/bin/sh

# Download the Book Review dataset:
if [ ! -r BX-SQL-Dump.zip ]
then
    wget "http://www2.informatik.uni-freiburg.de/~cziegler/BX/BX-SQL-Dump.zip"
fi

if [ ! -r BX-Users.sql ]
then
    unzip BX-SQL-Dump.zip
fi

# No data is ever that perfect for importing. While the SQL files are
# for MySQL We don't have the MyISAM loaded, so we'll remove that:
perl -pi -e s'/\) TYPE=MyISAM;/\);/' *.sql

PASSWORD=byebye
DBNAME=bx

ACS="mysql -u root -p$PASSWORD $DBNAME"
$ACS < BX-Book-Ratings.sql
$ACS < BX-Books.sql

# The following inserts 278858 user accounts with little information.
# We could probably make that a little more interesting by downloading
# standard fake data set of user names, but for now, we'll keep the
# santized data:
$ACS < BX-Users.sql
