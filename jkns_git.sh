#!/bin/bash

PROJECT=gvydemo
REPOSRC=git@github.com/mikechew/$PROJECT.git

LOCALREPO=.
LOCALREPO_DIR=$LOCALREPO/sampledb

# git config --global user.name "Michael Chew"
# git config --global user.email "michael.chew@actifio.com.au"

if [ ! -d $LOCALREPO_DIR/.git ]
then
    cd $LOCALREPO
    git clone $REPOSRC 
else
    cd $LOCALREPO_DIR
# git fetch    
    git pull 
fi

cd $LOCALREPO_DIR
