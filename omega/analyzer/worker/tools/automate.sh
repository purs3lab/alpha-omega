#!/bin/bash

if [ "$#" -lt 2 ]
then
  echo "Not enough arguments supplied. Usage: ./automate.sh <user> <repository>"
  exit 1
fi

git clone https://github.com/$1/$2 || exit 1
VERSION=$(cd ./$2 && git rev-parse --short HEAD && cd ..)
tar -czf $2.tar.gz $2
mkdir /opt/local_source/
mv $2.tar.gz /opt/local_source/ || exit 1
/opt/toolshed/runtools.sh pkg:github/$1/$2@$VERSION?local=true || exit 1
