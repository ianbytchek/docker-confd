#!/usr/bin/env sh

echo -n 'Moving confd into ´/usr/local/bin´… '
mv '/docker/confd' '/usr/local/bin'
echo ' OK!'

echo -n 'Cleaning up container…'

rm -rf /docker

echo ' OK!'

echo 'Bye-bye!'