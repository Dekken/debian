#!/usr/bin/env bash

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CWD/../system.sh
source $CWD/config.sh

if [ -z "$(which netselect-apt)" ]; then
    echo "installing netselect-apt"
    apt-get install -y netselect-apt
fi

VER=$(version)
URL=$(netselect-apt 2>&1 | grep -A 1 "fastest valid" | tail -n1 | xargs)
APT="/etc/apt/sources.list"
mv $APT ${$APT}.bk

echo "#deb http://httpredir.debian.org/debian $VER main" >> $APT
echo "" >> $APT     
echo "deb http://security.debian.org/ $VER/updates main" >> $APT
echo "deb $URL $VER main contrib" >> $APT
echo "#deb $URL $VER-backports main contrib" >> $APT

apt-get update
