#!/usr/bin/env bash

##default apt/sources.list
#deb http://httpredir.debian.org/debian jessie main
#deb http://security.debian.org/ jessie/updates main

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CWD/../system.sh

if [ -z "$(which netselect-apt)" ]; then
    echo "installing netselect-apt"
    apt-get install -y netselect-apt
fi

URL=$(netselect-apt 2>&1 | grep -A 1 "fastest valid" | tail -n1 | xargs)
APT="/etc/apt/sources.list"
rm $APT
echo "deb http://security.debian.org/ jessie/updates main" >> $APT
echo "deb $URL jessie main contrib" >> $APT
echo "deb $URL jessie-backports main contrib" >> $APT

apt-get udpate
