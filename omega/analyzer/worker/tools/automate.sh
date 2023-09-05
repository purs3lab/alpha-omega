#!/bin/bash

if [ "$#" -lt 2 ]
then
  echo "Not enough arguments supplied. Usage: ./automate.sh <user> <repository> [version]"
  exit 1
fi

git clone https://github.com/$1/$2
tar -czf $2.tar.gz $2
mkdir /opt/local_source/
mv $2.tar.gz /opt/local_source/
/opt/toolshed/runtools.sh pkg:github/$2@${3:-0}?local=true
