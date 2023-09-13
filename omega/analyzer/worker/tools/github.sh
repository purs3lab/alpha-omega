#!/bin/bash

if [ "$#" -lt 2 ]
then
  echo "Not enough arguments supplied. Usage: ./github.sh <user> <repository>"
  exit 1
fi

mkdir /opt/local_source
git clone https://github.com/$1/$2 /opt/local_source/$2 || exit 1
VERSION=$(git --git-dir=/opt/local_source/$2/.git rev-parse --short HEAD)
/opt/toolshed/runtools.sh pkg:github/$1/$2@$VERSION?local_source=true || exit 1
