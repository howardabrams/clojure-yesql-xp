#!/bin/sh -e

USER=vagrant        # Probably the default that is set
HOME=/home/$USER    # Also set ... but if not...
BIN=$HOME/bin

LEIN_URL="https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein"
LEIN=$BIN/lein

mkdir -p $BIN
if [ ! -f $LEIN ]
then
    wget --output-document=$LEIN $LEIN_URL
    chmod a+x $LEIN
fi

if [ ! -e $HOME/yesql-xp ]
then
    ln -s /vagrant/yesql-xp $HOME
fi

if [ ! -e $HOME/.lein/profiles.clj ]
then
    cat > $HOME/.lein/profiles.clj <<EOF
{:user {:plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.7"]]}}
EOF
fi

cd /vagrant/yesql-xp
$LEIN deps
