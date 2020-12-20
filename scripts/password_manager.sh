#!/usr/bin/env bash

echo -ne "\nNOTE:\n if it doesnt work, please try installing requirements:\n apt install -y pwgen apache2-utils\n\nEnjoy!\n\n"

if [ -z $1 ]
then
  echo "please provide a user name"
  exit 1
else
  read -p "name provided was $1, is this correct? [y/n]" -n 2 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo okay nice
  else
    echo name required please thank you
    exit 1
  fi
fi

if [ -z $2 ]
then
  pass=$(pwgen -s 64 | shuf)
  read -p "pass will be $pass, is this okay? [y/n]" -n 2 -r
else
  read -p "pass provided was $2, is this correct? [y/n]" -n 2 -r
  pass="$2"
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo okay nice
  else
    echo name required please thank you
    exit 1
  fi
fi

echo creating plaintext-$1 file with user/pass
echo user: $1 > overview-$1
echo $pass > plaintext-$1
echo pass: $pass >> overview-$1

echo creating htpasswd-$1 file for direct use in nginx configs
htpasswd -b -c htpasswd-$1 $1 $pass
echo "htpasswd: `cat htpasswd-$1`" >> overview-$1

echo creating http_auth-$1 file with basic auth token for use in aim homepage, grpc requests etc
echo "Basic $(echo -n $1:$pass | base64)" > http_auth-$1
echo "http_auth: `cat http_auth-$1`" >> overview-$1

echo creating password masked for linux user
echo $(openssl passwd -salt 3a34343a2 -1 $pass) > masked-$1
echo "masked: `cat masked-$1`" >> overview-$1
