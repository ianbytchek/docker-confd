#!/usr/bin/env sh

apk update
apk add go

echo -n 'Moving confd into ´/usr/local/bin´… '
mv '/docker/confd' '/usr/local/bin'
echo ' OK!'

echo -n 'Cleaning up container…'

rm -rf \
    /tmp/* \
    /var/tmp/* \
    /var/cache/* \
    /docker

echo ' OK!'

echo 'Bye-bye!'