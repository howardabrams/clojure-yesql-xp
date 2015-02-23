#!/bin/sh -e

USER=vagrant        # Probably the default that is set
HOME=/home/$USER    # Also set ... but if not...
BIN=$HOME/bin

LEIN_URL="https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein"
LEIN=$BIN/lein

mkdir -p $BIN
if [ ! -f $LEIN ]
then
    curl --output $LEIN $LEIN_URL
    chmod a+x $LEIN
fi

# cd $HOME
# $LEIN new yesql-xp
ln -s /vagrant/yesql-xp $HOME

cd /vagrant/yesql-xp
$LEIN deps
