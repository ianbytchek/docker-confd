#!/usr/bin/env sh

echo -n 'Moving confd binary into $PATH… '
mv '/docker/confd' '/usr/local/bin'
echo ' OK!'

echo -n 'Cleaning up container…'

rm -rf /docker

echo ' OK!'

echo 'Bye-bye!'